/******************************************************
// File Name:    hello.sv
// Function:     This program will print 'hello world'
// Author:       Shane Duffy
//*****************************************************
module hello_world ;  //  declare module
initial begin                //************************
  $display ("hello world");  // No comment necessary.
  $finish;                   //************************
end
endmodule  //  end of module
