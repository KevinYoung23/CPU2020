module fibonacci(
	input reset, //1 to reset
	input CLK,
	input [11:0] number, 
	input [1:0] stage,
	input [15:0] currentnum,
	input [11:0] address, //which to start
	output reg ready, //output signal shows the progress. 1 for done, 0 for in progress.
	output reg [15:0] out,
	output reg [11:0] counter
);

reg[15:0] num1, num2, temp;
//reg[11:0] counter; //control the number of loops

always@(posedge CLK) 
begin

	if(reset)  //reset all the registers when the reset signal is 1. Can be active low if wanted.
	begin
		num1 <= 16'b0;
		num2 <= 16'b1;
		temp <= 16'b0;
		counter <= 12'b0;
		ready <= 0;
		out <= 16'b0;
	end 
	
	else	
	begin
		if(stage == 1)
		begin 
			num1 <= currentnum;
			out <= num1; //delete when finish debugging
		end
		else if(stage == 2)
		begin 
			num2 <= currentnum;
			counter <= address;
			out <= num1	; // delete
		end
		else 
		begin 
			if(counter == number) 
			begin
				out <= num2;
				ready <= 1;
			end
		
			else
			begin 
				temp = num2; 
				num2 = num1 + temp;
				num1 = temp;
				out <= num2;
				ready <= 0;
				counter <= counter + 1;
			end
		end
	end
end



endmodule 