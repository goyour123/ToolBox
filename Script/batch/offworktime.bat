
@set year=%date:~0,4%
@set month=%date:~5,2%
@set day=%date:~8,2%

@for /f "tokens=2,3,4,5,6 delims=,/ " %%a in ('systeminfo') do @(
  @if %%a equ %year% (
    @if %%b equ %month% (
      @if %%c equ %day% (
        @set boottime="%%a/%%b/%%c, %%d %%e"
      )
    )
  )
)

@pushd "C:\Users\%USERNAME%\Desktop"
@echo %boottime% >> Boot.txt
@popd
