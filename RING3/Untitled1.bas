'#define IoGetCurrentIrpStackLocation( Irp ) ( (Irp)->Tail.Overlay.CurrentStackLocation )


'    NT_ASSERT(Irp->CurrentLocation <= Irp->StackCount + 1);
'    return Irp->Tail.Overlay.CurrentStackLocation;


'typedef struct _DISPATCHER_HEADER {
'    union {
'        union {
'            volatile LONG Lock;
'            LONG LockNV;
'        } DUMMYUNIONNAME;

'        struct {                            // Events, Semaphores, Gates, etc.
'            UCHAR Type;                     // All (accessible via KOBJECT_TYPE)
'            UCHAR Signalling;
'            UCHAR Size;
'            UCHAR Reserved1;
'        } DUMMYSTRUCTNAME;

'        struct {                            // Timer
'            UCHAR TimerType;
'            union {
'                UCHAR TimerControlFlags;
'                struct {
'                    UCHAR Absolute : 1;
'                    UCHAR Wake : 1;
'                    UCHAR EncodedTolerableDelay : TIMER_TOLERABLE_DELAY_BITS;
'                } DUMMYSTRUCTNAME;
'            };

'            UCHAR Hand;
'            union {
'                UCHAR TimerMiscFlags;
'                struct {

'#if !defined(KENCODED_TIMER_PROCESSOR)

'                    UCHAR Index : TIMER_EXPIRED_INDEX_BITS;

'#else

'                    UCHAR Index : 1;
'                    UCHAR Processor : TIMER_PROCESSOR_INDEX_BITS;

'#endif

'                    UCHAR Inserted : 1;
'                    volatile UCHAR Expired : 1;
'                } DUMMYSTRUCTNAME;
'            } DUMMYUNIONNAME;
'        } DUMMYSTRUCTNAME2;

'        struct {                            // Timer2
'            UCHAR Timer2Type;
'            union {
'                UCHAR Timer2Flags;
'                struct {
'                    UCHAR Timer2Inserted : 1;
'                    UCHAR Timer2Expiring : 1;
'                    UCHAR Timer2CancelPending : 1;
'                    UCHAR Timer2SetPending : 1;
'                    UCHAR Timer2Running : 1;
'                    UCHAR Timer2Disabled : 1;
'                    UCHAR Timer2ReservedFlags : 2;
'                } DUMMYSTRUCTNAME;
'            } DUMMYUNIONNAME;

'            UCHAR Timer2ComponentId;
'            UCHAR Timer2RelativeId;
'        } DUMMYSTRUCTNAME3;

'        struct {                            // Queue
'            UCHAR QueueType;
'            union {
'                UCHAR QueueControlFlags;
'                struct {
'                    UCHAR Abandoned : 1;
'                    UCHAR DisableIncrement : 1;
'                    UCHAR QueueReservedControlFlags : 6;
'                } DUMMYSTRUCTNAME;
'            } DUMMYUNIONNAME;

'            UCHAR QueueSize;
'            UCHAR QueueReserved;
'        } DUMMYSTRUCTNAME4;

'        struct {                            // Thread
'            UCHAR ThreadType;
'            UCHAR ThreadReserved;
'            union {
'                UCHAR ThreadControlFlags;
'                struct {
'                    UCHAR CycleProfiling : 1;
'                    UCHAR CounterProfiling : 1;
'                    UCHAR GroupScheduling : 1;
'                    UCHAR AffinitySet : 1;
'                    UCHAR Tagged : 1;
'                    UCHAR EnergyProfiling: 1;

'#if !defined(_X86_)

'                    UCHAR ThreadReservedControlFlags : 2;

'#else

'                    UCHAR Instrumented : 1;
'                    UCHAR ThreadReservedControlFlags : 1;

'#endif

'                } DUMMYSTRUCTNAME;
'            } DUMMYUNIONNAME;

'            union {
'                UCHAR DebugActive;

'#if !defined(_X86_)

'                struct {
'                    BOOLEAN ActiveDR7 : 1;
'                    BOOLEAN Instrumented : 1;
'                    BOOLEAN Minimal : 1;
'                    BOOLEAN Reserved4 : 3;
'                    BOOLEAN UmsScheduled : 1;
'                    BOOLEAN UmsPrimary : 1;
'                } DUMMYSTRUCTNAME;

'#endif

'            } DUMMYUNIONNAME2;
'        } DUMMYSTRUCTNAME5;

'        struct {                         // Mutant
'            UCHAR MutantType;
'            UCHAR MutantSize;
'            BOOLEAN DpcActive;
'            UCHAR MutantReserved;
'        } DUMMYSTRUCTNAME6;
'    } DUMMYUNIONNAME;

'    LONG SignalState;                   // Object lock
'    LIST_ENTRY WaitListHead;            // Object lock
'} DISPATCHER_HEADER, *PDISPATCHER_HEADER;