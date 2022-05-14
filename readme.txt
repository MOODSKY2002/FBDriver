此FB代码需要FB1.09版本才能正常编译!!!!
FB研究QQ群324785043

This FB code requires FB1 09 version can be compiled normally!!!!

示例包含：
PsSetCreateProcessNotifyRoutineEx 回调示例
RING3+RING0事件通讯示例

Examples include:
Pssetcreateprocessnotifyroutineex callback example
RING3 + ring0 event communication example


怀疑FB不支持volatile、POINTER_ALIGNMENT,导致_IO_STACK_LOCATION类型在FB里无法正确获取到信息,所以获取IoContrlCode由MinGw编译静态库来实现

It is suspected that FB does not support volatile and pointer_ Alignment, resulting in_ IO_ STACK_ The location type cannot get the information correctly in FB, so obtaining the iocontrlcode is implemented by MinGW compiling the static library
