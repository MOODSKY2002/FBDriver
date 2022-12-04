此FB代码需要FB1.09版本才能正常编译!!!!
FB研究QQ群324785043

全GitHub上IOCTL_AFD_GET_SOCK_NAME值都是错的!!!!!
如果能搜索出来这个结果算你兄弟运气好，找到了正确值!
#define IOCTL_AFD_GET_PEER_NAME &H00012033 ->Error!!!!
#define IOCTL_AFD_GET_PEER_NAME &H0001203F ->Pass!!!!

This FB code requires FB1 09 version can be compiled normally!!!!

示例包含：
PsSetCreateProcessNotifyRoutineEx 回调示例
RING3+RING0事件通讯示例

Examples include:
Pssetcreateprocessnotifyroutineex callback example
RING3 + ring0 event communication example


怀疑FB不支持volatile、POINTER_ALIGNMENT,导致_IO_STACK_LOCATION类型在FB里无法正确获取到信息,所以获取IoContrlCode由MinGw编译静态库来实现

It is suspected that FB does not support volatile and pointer_ Alignment, resulting in_ IO_ STACK_ The location type cannot get the information correctly in FB, so obtaining the iocontrlcode is implemented by MinGW compiling the static library
