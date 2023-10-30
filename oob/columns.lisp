(module oob)

(defcolumns 
  STAMP
  CT
  CT_MAX
  (INCOMING_DATA :array [6])
  (OOB_EVENT :boolean :array [2])
  (INCOMING_INST :display :opcode) ;; all calls and creates are grouped under the same instruction
  (IS_JUMP :boolean)
  (IS_JUMPI :boolean)
  (IS_RDC :boolean)
  (IS_CDL :boolean)
  (IS_CALL :boolean)
  (IS_CREATE :boolean)
  (IS_SSTORE :boolean)
  (IS_RETURN :boolean)
  (WCP_FLAG :boolean)
  (ADD_FLAG :boolean)
  (OUTGOING_INST :display :opcode)
  (OUTGOING_DATA :array [4])
  (OUTGOING_RES_LO :boolean))


