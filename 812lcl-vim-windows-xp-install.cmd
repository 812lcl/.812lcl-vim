@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_DIR=%HOME%\.812lcl-vim

@if not exist "%APP_DIR%" (
        echo backing up existing vim config
        @set today=%DATE%
        @if exist "%HOME%\.vim" call xcopy /s/e/h/y/r/q/i "%HOME%\.vim" "%HOME%\.vim.%today%"
        @if exist "%HOME%\.vimrc" call copy "%HOME%\.vimrc" "%HOME%\.vimrc.%today%"
        @if exist "%HOME%\_vimrc" call copy "%HOME%\_vimrc" "%HOME%\_vimrc.%today%"
        @if exist "%HOME%\.gvimrc" call copy "%HOME%\.gvimrc" "%HOME%\.gvimrc.%today%"
        )

@if exist "%APP_DIR%" (
        @set ORIGINAL_DIR=%CD%
        echo updating 812lcl-vim
        chdir /d "%APP_DIR%" && git pull
        chdir /d "%ORIGINAL_DIR%"
        ) else (
            echo cloning 812lcl-vim
            call git clone git://github.com/812lcl/812lcl-vim.git "%APP_DIR%"
        )

@if not exist  "%APP_DIR%\.vim\bundle" call mkdir "%APP_DIR%\.vim\bundle"
call xcopy /s/e/h/y/r/q/i "%APP_DIR%\.vim" "%HOME%\.vim"
call copy "%APP_DIR%\.vimrc" "%HOME%\.vimrc"
call copy "%APP_DIR%\.vimrc" "%HOME%\_vimrc"
call copy "%APP_DIR%\.vimrc.fork" "%HOME%\.vimrc.fork"
call copy "%APP_DIR%\.vimrc.bundles" "%HOME%\.vimrc.bundles"
call copy "%APP_DIR%\.vimrc.bundles.fork" "%HOME%\.vimrc.bundles.fork"
call copy "%APP_DIR%\.vimrc.before" "%HOME%\.vimrc.before"
call copy "%APP_DIR%\.vimrc.before.fork" "%HOME%\.vimrc.before.fork"

@if not exist "%HOME%/.vim/bundle/vundle" call git clone https://github.com/gmarik/vundle.git "%HOME%/.vim/bundle/vundle"
call vim -u "%APP_DIR%/.vimrc.bundles" - +BundleInstall! +BundleClean +qall
