@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_DIR=%HOME%\.812lcl-vim
IF NOT EXIST "%APP_DIR%" (
  call git clone https://github.com/812lcl/.812lcl-vim.git "%APP_DIR%"
) ELSE (
	@set ORIGINAL_DIR=%CD%
    echo updating 812lcl-vim
    chdir /d "%APP_DIR%"
	call git pull
    chdir /d "%ORIGINAL_DIR%"
	call cd "%APP_DIR%"
)

call mklink "%HOME%\.vimrc" "%APP_DIR%\.vimrc"
call mklink "%HOME%\_vimrc" "%APP_DIR%\.vimrc"
call mklink "%HOME%\.vimrc.plugins" "%APP_DIR%\.vimrc.plugins"
call mklink "%HOME%\.vimrc.before" "%APP_DIR%\.vimrc.before"
call mklink "%HOME%\.vimrc.menu" "%APP_DIR%\.vimrc.menu"
call mklink /J "%HOME%\.vim" "%APP_DIR%\.vim"

IF NOT EXIST "%APP_DIR%\.vim\bundle" (
	call mkdir "%APP_DIR%\.vim\bundle"
	call mkdir "%APP_DIR%\.vim\.vimtmp"
	call mkdir "%APP_DIR%\.vim\.vimtmp\undo"
)

IF NOT EXIST "%HOME%\vim-plug" (
	call git clone https://github.com/junegunn/vim-plug.git "%HOME%\vim-plug"
) ELSE (
	@set ORIGINAL_DIR=%CD%
	echo updating vim-plug
	chdir "%HOME%\vim-plug"
	call git pull
	chdir /d "%ORIGINAL_DIR%"
	call cd "%APP_DIR%"
)

call mkdir "%APP_DIR%\.vim\autoload"
call copy "%HOME%\vim-plug\plug.vim" "%APP_DIR%\.vim\autoload"

call gvim -u "%APP_DIR%/.vimrc.plugins" +PlugInstall! +PlugClean +qall
