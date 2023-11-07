(module oob)

(defcolumns 
  STAMP
  CT
  CT_MAX
  (INCOMING_DATA :array [6])
  (OOB_EVENT :binary :array [2])
  (INCOMING_INST :byte :display :opcode) ;; all calls and creates are grouped under the same instruction
  (IS_JUMP :binary)
  (IS_JUMPI :binary)
  (IS_RDC :binary)
  (IS_CDL :binary)
  (IS_CALL :binary)
  (IS_CREATE :binary)
  (IS_SSTORE :binary)
  (IS_RETURN :binary)
  (WCP_FLAG :binary)
  (ADD_FLAG :binary)
  (OUTGOING_INST :byte :display :opcode)
  (OUTGOING_DATA :array [4])
  (OUTGOING_RES_LO :binary))


