module fibv1_0(
	input [11:0] number,
	input reset, 
	input CLK,
	output reg [15:0] out,
	output reg ready

);

reg[15:0] num1, num2;
reg[11:0] counter;


always@(posedge CLK) 
begin
	if(reset)
	begin 
		num1 <= 16'b0;
		num2 <= 16'b1;
		counter <= 12'b0;
		ready <= 0;
	end 
	else 
	begin 
		if((counter == number))
		begin
			out <= num2;
			ready <= 1;
		end
		
		else
		begin 
			num2 <= num1 + num2;
			num1 <= num2;
			out <= num1 + num2;
			ready <= 0;
			counter <= counter + 1;
		end
	end	
end

endmodule 