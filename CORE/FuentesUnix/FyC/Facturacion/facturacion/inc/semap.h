
int   ifnLockSemForRead(key_t kKey, int iFlags);
int   ifnUnlockSemForRead(key_t kKey, int iFlags);
int   ifnLockSemForWrite(key_t kKey, int iFlags);
int   ifnUnlockSemForWrite(key_t kKey, int iFlags);
int   ifnOpenShared(key_t Key, long Size, int Flags, int *iDescriptor);
int   ifnAttachShared(int iDescriptor, int Flags, void **pMemory);
int   ifnDettachShared(void *pShared);
int   ifnRemoveShared(int iDescriptor);
int   ifnLockSemDataAndWaitForReaders(key_t Key, int iFlags);

