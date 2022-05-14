FBDDK.c 为MinGw代码

之所以这里用MinGW生成.a来实现，原因是怀疑FB不支持volatile、POINTER_ALIGNMENT
导致_IO_STACK_LOCATION类型在FB里无法正确获取到信息


FBDDK. C is MinGW code

The reason why MinGW is used here is to generate A. the reason is that FB does not support volatile and pointer_ Alignment, resulting in_ IO_ STACK_ Location type cannot get information correctly in FB