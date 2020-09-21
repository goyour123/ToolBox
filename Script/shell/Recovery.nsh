# 
# Write 0x44 to cd4/cd5 offset 0x80-0x88
#
mm cd4 80 -w 1 -io -n
mm cd5 44 -w 1 -io -n
mm cd4 81 -w 1 -io -n
mm cd5 44 -w 1 -io -n
mm cd4 82 -w 1 -io -n
mm cd5 44 -w 1 -io -n
mm cd4 83 -w 1 -io -n
mm cd5 44 -w 1 -io -n
mm cd4 84 -w 1 -io -n
mm cd5 44 -w 1 -io -n
mm cd4 85 -w 1 -io -n
mm cd5 44 -w 1 -io -n
mm cd4 86 -w 1 -io -n
mm cd5 44 -w 1 -io -n
mm cd4 87 -w 1 -io -n
mm cd5 44 -w 1 -io -n
mm cd4 88 -w 1 -io -n
mm cd5 44 -w 1 -io -n

stall 1000000
reset
