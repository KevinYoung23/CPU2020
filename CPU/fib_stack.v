module fib_stack(
	input [11:0] number, //operand
	input CLK,
	input reset,
	input ready, 
	input [11:0] counter,
	output reg wren,
	output reg [11:0] address,
	output reg [1:0] stage
);

reg [11:0] bsf;

initial
begin 
	bsf <= 12'b0;
	stage <= 2'b00;
	address <= 12'b0;
end


always@(posedge CLK)
begin
	if (reset)
	begin
		wren <= 0;
		stage <= 2'b00;
	end
	
	else 
	begin
			if(number <= bsf)
			begin 
				wren <= (number == 0) ? 1 : 0;
				address <= number;
				stage <= 2'b11; 
			end	
			else 
			begin
				if(bsf < 1)
				begin 
					address <= (counter == number) ?  address : address + 1;
					wren <= 1;
					stage <= 2'b00;
					bsf <= (counter == number) ? number : bsf;
				end	
				else 
				begin 
					if(stage == 0) 
					begin 
						wren <= 0;
						address <= bsf - 1;
						stage <= 2'b01;
					end
					else if(stage == 1)
					begin 
						wren <= 0;
						address <= bsf;
						stage <= 2'b10;
					end
					else
					begin 
						wren <= 1;
						address = bsf + 1;
						bsf = bsf + 1;
						stage = 2'b11;
					end
				end	
			
		end
	end
end

endmodule 