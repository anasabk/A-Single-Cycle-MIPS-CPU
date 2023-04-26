print('please enter the file\'s name/path: ')
file_path = input()
print('what is the type the file? (mif or mem)')
file_type = input()
print('what to name the file? ')
file_name = input()


dictionary = {
    "add"   : ["000000", "100000"],
    "addi"  : ["001000"],
    "sub"   : ["000000", "100010"],
    "and"   : ["000000", "100100"],
    "andi"  : ["001100"],
    "or"    : ["000000", "100101"],
    "ori"   : ["001101"],
    "slt"   : ["000000", "101011"],
    "slti"  : ["001011"],
    "srl"   : ["000000", "000110"],
    "sll"   : ["000000", "000111"],
    "li"    : ["001111"],
    "lw"    : ["100011"],
    "sw"    : ["101011"],
    "beq"   : ["000100"],
    "bne"   : ["000101"],
    "j"     : ["000010"],
    "jal"   : ["000011"],
    "jr"    : ["000000", "001000"],
    "mult"  : ["011000"]
}

byte_code_list = []

with open(file_path, 'r') as assembly_f :
    for instruction in assembly_f :
        if instruction != '\n' :
            temp = instruction.replace('$', '')
            temp = temp.replace(',', ' ')
            temp = temp.replace('(', ' ')
            temp = temp.replace(')', ' ')
            parts = temp.split()

            operation = dictionary.get(parts[0])
            byte_code = operation[0]
            
            if len(operation) > 1 :
                if (parts[0] == 'srl') or (parts[0] == 'sll') :
                    byte_code += '0000'
                    byte_code += format(int(parts[2]), '04b')
                    byte_code += format(int(parts[1]), '04b')
                    byte_code += format(int(parts[3]), '04b')

                elif (parts[0] == 'jr') :
                    byte_code += format(int(parts[1]), '04b')
                    byte_code += format(0, '012b')

                else :
                    byte_code += format(int(parts[2]), '04b')
                    byte_code += format(int(parts[3]), '04b')
                    byte_code += format(int(parts[1]), '04b')
                    byte_code += '0000'

                byte_code += operation[1]
                byte_code += '0000'

            elif len(operation) == 1 :
                if (parts[0] == 'j') or (parts[0] == 'jal') :
                    byte_code += format(int(parts[1]), '010b')
                    byte_code += format(0, '016b')

                elif parts[0] == 'li' :
                    byte_code += '0000'
                    byte_code += format(int(parts[1]), '04b')
                    byte_code += format(int(parts[2]), '016b')
                    byte_code += '00'

                elif (parts[0] == 'lw') or (parts[0] == 'sw') :
                    byte_code += format(int(parts[3]), '04b')
                    byte_code += format(int(parts[1]), '04b')
                    byte_code += format(int(parts[2]), '016b')
                    byte_code += '00'

                elif (parts[0] == 'mult') :
                    byte_code += format(int(parts[1]), '04b')
                    byte_code += format(int(parts[2]), '04b')
                    byte_code += format(0, '018b')

                else :
                    byte_code += format(int(parts[2]), '04b')
                    byte_code += format(int(parts[1]), '04b')
                    byte_code += format(int(parts[3]), '016b')
                    byte_code += '00'
                
            else :
                exit

            byte_code_list.append(byte_code)

with open('C:/Users/anasa/Documents/Quartus/Final_project/' + file_name + '.' + file_type, 'w') as byte_code_f :
    if file_type == 'mif' :
        byte_code_f.write('WIDTH=32;\nDEPTH=1024;\n\nADDRESS_RADIX=UNS;\nDATA_RADIX=BIN;\n\nCONTENT BEGIN\n')
        counter = 0
        for instruction in byte_code_list :
            byte_code_f.write('\t' + str(counter) + '     :   ')
            byte_code_f.write(instruction)
            byte_code_f.write(';\n')
            counter += 1

        for line in range(counter, 1024) :
            byte_code_f.write('\t' + str(line) + '     :   ')
            byte_code_f.write(format(0, '032b'))
            byte_code_f.write(';\n')

        byte_code_f.write('END;')

    elif file_type == 'mem' :
        for instruction in byte_code_list :
            byte_code_f.write(instruction)
            byte_code_f.write('\n')

        for line in range(len(byte_code_list), 1024) :
            byte_code_f.write(format(0, '032b') + '\n')