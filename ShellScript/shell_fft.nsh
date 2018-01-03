set h2offt "\H2OFFT_SHELL\H2OFFT-Sx64.efi"
set binary "isflash.bin"

if exist %1 then
set binary %1
endif

%h2offt% %binary% /all