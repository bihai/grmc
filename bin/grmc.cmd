@setlocal enabledelayedexpansion enableextensions
@set ROOT_WIN=%~dp0..\lib-exec
@set ROOT=%ROOT_WIN:\=/%
@set FILE=%~f1
@set EXT=%~x1
@set EXT_VALID=0
@set VALID_EXTS=.grm .egt
@if not defined MAKE @set MAKE=make

@for %%E in (%VALID_EXTS%) do @if /i "%EXT%" == "%%E" set EXT_VALID=1

@if defined FILE @(
    if %EXT_VALID% EQU 0 (
        echo The extension "%EXT%" is not supported by %~n0, please choose one of {%VALID_EXTS%} 1>&2
        exit /b 1
    )

    if /i "%EXT%" EQU ".grm" set FILE=%~dp1%~n1.egt
    set FILE=!FILE:\=/!
    call "%MAKE%" -s -f "%ROOT_WIN%\grmc.makefile" MAKE="%MAKE%" ROOT="!ROOT!" "!FILE!"
) else (
    echo Please specify a grammar file to be compiled or an egt file to be recompiled 1>&2
    exit /b 1
)
