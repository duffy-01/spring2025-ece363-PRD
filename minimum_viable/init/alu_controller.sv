`include "definitions.sv"

module alu_controller(
    input [6:0] opcode,
    input [2:0] funct3,
    input [4:0] funct5,
    output reg [3:0] alu_control
);

    always @(*) begin
        case (opcode)
            `OPCODE_I: begin
                case (funct3)
                    `FUNCT3_ADDI: alu_control = `ALU_ADD;
                    `FUNCT3_ANDI: alu_control = `ALU_AND;
                    `FUNCT3_ORI:  alu_control = `ALU_OR;
                    default: alu_control = `ALU_ADD;
                endcase
            end

            `OPCODE_ATM: begin
                case (funct5)
                    `F5_ATM_SWAP: alu_control = `ALU_SWAP;
                    `F5_ATM_ADD: alu_control = `ALU_ADD; 
                    `F5_ATM_AND: alu_control = `ALU_AND;
                    `F5_ATM_OR:  alu_control = `ALU_OR;
                    `F5_ATM_XOR: alu_control = `ALU_XOR;
                    `F5_ATM_MIN: alu_control = `ALU_MIN;
                    `F5_ATM_MAX: alu_control = `ALU_MAX;
                    `F5_ATM_LR:  alu_control = `ALU_LR;
                    `F5_ATM_SC:  alu_control = `ALU_SC;
                    default: alu_control = `ALU_ADD;
                endcase
            end
            
            default: alu_control = `ALU_ADD;
        endcase
    end
endmodule
