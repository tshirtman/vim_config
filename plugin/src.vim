function! SetupLocationListMapping()
    " Get the location list for the current window
    let loc_list = getloclist(0)

    " Check if the location list was populated by our plugin
    if !empty(loc_list) && has_key(loc_list[0], 'user_data') && loc_list[0]['user_data']['is_custom_plugin'] == 1
        " Set the key mapping for the current buffer
        nnoremap <buffer> <CR> :call OpenURLInBrowser()<CR>
    endif
endfunction

function! DisplayJsonAndError(json_string, error_message)
    " Open a new scratch buffer
    tabnew
    enew
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    file JSON Debug

    " Display the JSON document and the error message
    call setline(1, "Error parsing JSON:")
    call append(1, a:error_message)
    call append(line('$'), '')
    call append(line('$'), 'JSON Document:')
    call append(line('$'), split(a:json_string, '\n'))

    " Optionally, syntax highlight as JSON
    set filetype=json
endfunction


function! QueryAndPopulateLocationList()
    " Prompt for a query
    if empty($SRC_ENDPOINT) || empty($SRC_ACCESS_TOKEN)
        echoerr "Error: Environment variables SRC_ENDPOINT and SRC_ACCESS_TOKEN must be set and not empty."
        return
    endif
    let query = input('Enter your query: ')

    " Run the external command and capture the output
    " Assuming `mycommand` is the command to run
    let wrapped_query = "'" . query . "'"

    let command = "src search " . shellescape(wrapped_query)
    let output = system(command)

    " Parse the JSON output
    " Attempt to parse the JSON output
    let json_data = {}
    try
        let json_data = json_decode(output)
    catch
        " Display the error and the raw JSON in a new buffer
        call DisplayJsonAndError(output, v:exception)
        return
    endtry

    " Check if JSON data is valid
    if type(json_data) != type({})
        call DisplayJsonAndError(output, "Output is not a valid JSON object")
        return
    endif

    if !has_key(json_data, 'Results')
        call DisplayJsonAndError(output, "No 'Results' field in JSON output")
        return
    endif

    if type(json_data) != type({})
        echo "Error: Output is not a valid JSON object"
        return
    endif

    " Ensure "Results" field exists
    if !has_key(json_data, 'Results')
        echo "Error: No 'Results' field in JSON output"
        return
    endif

    let results = json_data['Results']

    " Prepare the location list items
    let loc_list = []
    for item in results
        if has_key(item, 'preview') && has_key(item, 'url')
            call add(loc_list, {
                        \ 'text': item['preview'],
                        \ 'lnum': 1,  " line number can be adjusted as needed
                        \ 'col': 1,   " column number can be adjusted as needed
                        \ 'filename': item['url']  " Store the URL in the filename field
                        \ })
        endif
    endfor

    " Populate the location list with the collected items
    call setloclist(0, loc_list, 'r')

    " Open the location list window
    lopen

    call SetupLocationListMapping()
endfunction


function! OpenURLInBrowser()
    " Get the current entry in the location list
    let lnum = line('.')
    let loc_list = getloclist(0)

    " Extract the URL from the 'filename' field
    let url = loc_list[lnum - 1].filename

    " Determine the OS and set the command to open the URL
    if has('mac')
        let open_cmd = 'open'
    elseif has('unix')
        let open_cmd = 'xdg-open'
    elseif has('win32') || has('win64')
        let open_cmd = 'start'
    else
        echo "Unsupported OS."
        return
    endif

    " Use the system's default browser to open the URL
    if !empty(url)
        silent execute '!' . open_cmd . ' ' . shellescape(url)
    else
        echo "No URL associated with this item."
    endif
endfunction

" autocmd! FileType qf nnoremap <buffer> <CR> :call OpenURLInBrowser()<CR>
"
nnoremap <Leader>q :call QueryAndPopulateLocationList()<CR>
