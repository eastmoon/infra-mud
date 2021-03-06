@rem
@rem Copyright 2020 the original author jacky.eastmoon
@rem All commad module need 3 method :
@rem [command]        : Command script
@rem [command]-args   : Command script options setting function
@rem [command]-help   : Command description
@rem Basically, CLI will not use "--options" to execute function, "--help, -h" is an exception.
@rem But, if need exception, it will need to thinking is common or individual, and need to change BREADCRUMB variable in [command]-args function.
@rem NOTE, batch call [command]-args it could call correct one or call [command] and "-args" is parameter.
@rem

:: ------------------- batch setting -------------------
@rem setting batch file
@rem ref : https://www.tutorialspoint.com/batch_script/batch_script_if_else_statement.htm
@rem ref : https://poychang.github.io/note-batch/

@echo off
setlocal
setlocal enabledelayedexpansion

:: ------------------- declare CLI file variable -------------------
@rem retrieve project name
@rem Ref : https://www.robvanderwoude.com/ntfor.php
@rem Directory = %~dp0
@rem Object Name With Quotations=%0
@rem Object Name Without Quotes=%~0
@rem Bat File Drive = %~d0
@rem Full File Name = %~n0%~x0
@rem File Name Without Extension = %~n0
@rem File Extension = %~x0

set CLI_DIRECTORY=%~dp0
set CLI_FILE=%~n0%~x0
set CLI_FILENAME=%~n0
set CLI_FILEEXTENSION=%~x0

:: ------------------- declare CLI variable -------------------

set BREADCRUMB=cli
set COMMAND=
set COMMAND_BC_AGRS=
set COMMAND_AC_AGRS=

:: ------------------- declare variable -------------------

for %%a in ("%cd%") do (
    set PROJECT_NAME=%%~na
)
set PROJECT_ENV=dev
set VARNUMBER1=0
set VARNUMBER2=0
set VARTEST=0

:: ------------------- execute script -------------------

call :main %*
goto end

:: ------------------- declare function -------------------

:main (
    set COMMAND=
    set COMMAND_BC_AGRS=
    set COMMAND_AC_AGRS=
    call :argv-parser %*
    call :main-args-parser %COMMAND_BC_AGRS%
    IF defined COMMAND (
        set BREADCRUMB=%BREADCRUMB%-%COMMAND%
        findstr /bi /c:":!BREADCRUMB!" %CLI_FILE% >nul 2>&1
        IF errorlevel 1 (
            goto cli-help
        ) else (
            call :main %COMMAND_AC_AGRS%
        )
    ) else (
        call :%BREADCRUMB%
    )
    goto end
)
:main-args-parser (
    for /f "tokens=1*" %%p in ("%*") do (
        for /f "tokens=1,2 delims==" %%i in ("%%p") do (
            call :%BREADCRUMB%-args %%i %%j
            call :common-args %%i %%j
        )
        call :main-args-parser %%q
    )
    goto end
)
:common-args (
    set COMMON_ARGS_KEY=%1
    set COMMON_ARGS_VALUE=%2
    if "%COMMON_ARGS_KEY%"=="-h" (set BREADCRUMB=%BREADCRUMB%-help)
    if "%COMMON_ARGS_KEY%"=="--help" (set BREADCRUMB=%BREADCRUMB%-help)
    goto end
)
:argv-parser (
    for /f "tokens=1*" %%p in ("%*") do (
        IF NOT defined COMMAND (
            echo %%p | findstr /r "\-" >nul 2>&1
            if errorlevel 1 (
                set COMMAND=%%p
            ) else (
                set COMMAND_BC_AGRS=!COMMAND_BC_AGRS! %%p
            )
        ) else (
            set COMMAND_AC_AGRS=!COMMAND_AC_AGRS! %%p
        )
        call :argv-parser %%q
    )
    goto end
)

:: ------------------- Main method -------------------

:cli (
    goto cli-help
)

:cli-args (
    set COMMON_ARGS_KEY=%1
    set COMMON_ARGS_VALUE=%2
    if "%COMMON_ARGS_KEY%"=="--prod" (set PROJECT_ENV=prod)
    goto end
)

:cli-help (
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo If not input any command, at default will show HELP
    echo.
    echo Options:
    echo      --help, -h        Show more information with CLI.
    echo      --prod            Setting project environment with "prod", default is "dev"
    echo.
    echo Command:
    echo      up                Startup LDMud service.
    echo      down              Close down LDMud service.
    echo.
    echo Run 'cli [COMMAND] --help' for more information on a command.
    goto end
)

:: ------------------- Common Command method -------------------

:: ------------------- Command "up" method -------------------

:cli-up (
    echo ^> FluffOS service startup

    @rem check docker container exist or not
    docker ps -a > .dockerps.log
    for /f "tokens=*" %%p in ('findstr /R fluffos-service .dockerps.log') do (
        set IS_CONTAINER_EXIST=true
    )
    del .dockerps.log

    @rem startup container with docker
    if NOT defined IS_CONTAINER_EXIST (
        echo ^> Build FluffOS service image
        docker build -t fluffos .\docker\fluffos

        echo ^> Run FluffOS service
        docker run -d --rm ^
            -p 4000:4000 ^
            -p 4001:4001 ^
            --name fluffos-service ^
            fluffos

        echo ^> Use Telnet to connecnt fluffos-service with port 4000 for telnet, 4001 for binary.
    ) else (
        echo ^> fluffos-service is working.
    )
    goto end
)

:cli-up-args (
    goto end
)

:cli-up-help (
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup LDMud service
    echo.
    echo Options:
    echo      --help, -h        Show more information with UP Command.
    goto end
)


:: ------------------- Command "down" method -------------------

:cli-down (
    echo ^> FluffOS service close down
    docker rm -f fluffos-service
    goto end
)

:cli-down-args (
    goto end
)

:cli-down-help (
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Close down LDMud service
    echo.
    echo Options:
    echo      --help, -h        Show more information with UP Command.
    goto end
)

:: ------------------- End method-------------------

:end (
    endlocal
)
