@Echo Off
Rem PS1 script launcher
Rem PS1 file can't be run directly so you need a launcher
Rem Started in minimized mode using the parameter Minimized
Rem Starts in hidden mode with the parameter Hidden
Rem Other parameters are passed to the PS1 script.
SetLocal EnableDelayedExpansion
Title %~n0
CD /D "%~dp0"
Set Path=!Path!;!SystemRoot!\System32\WindowsPowerShell\v1.0\
If /I "%1"=="Minimized" (
    Shift /1
    PowerShell -ExecutionPolicy Unrestricted -NoProfile -WindowStyle Minimized -File %~dpn0.ps1 %*
    Set ExitCode=!ErrorLevel!
    If Not "!ExitCode!"=="0" (
        Echo.
        Echo Exit Code: !ExitCode! 1>&2
        Echo.
        Pause
    )
) Else If /I "%1"=="Hidden" (
    Shift /1
    PowerShell -ExecutionPolicy Unrestricted -NoProfile -WindowStyle Hidden -File "%~dpn0.ps1" %* > %~dpn0.Out
    Set ExitCode=!ErrorLevel!
    If Not "!ExitCode!"=="0" (
        Echo.
        Echo Exit Code: !ExitCode! 1>&2
    )
) Else (
    PowerShell -ExecutionPolicy Unrestricted -NoProfile -File "%~dpn0.ps1" %*
    Set ExitCode=!ErrorLevel!
    Echo.
    Pause
)
Exit !ExitCode!