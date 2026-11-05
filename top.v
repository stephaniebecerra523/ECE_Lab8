
`timescale 1ns / 1ps

module demux(
    input [3:0] In,
    input [1:0] Sel,
    input Enable,
    output [3:0] local_lib,
    output [7:4] fire_department,
    output [11:8] school,
    output [15:12] rib_shack
    );

    assign local_lib = Enable ? (Sel == 2'b00 ? In : 0) : 0;
    assign fire_department = Enable ? (Sel == 2'b01 ? In : 0) : 0;
    assign school = Enable ? (Sel == 2'b10 ? In : 0) : 0;
    assign rib_shack = Enable ? (Sel == 2'b11 ? In : 0) : 0;

endmodule


module ternary_4_mux(
    input [1:0] Sel,
    input [3:0] CEO, You, Fred, Jill,
    input Enable,
    output [3:0] person
    );

    assign person = Enable ?
        ((Sel == 2'b00) ? CEO :
         (Sel == 2'b01) ? You :
         (Sel == 2'b10) ? Fred : Jill) : 0;

endmodule


module top(
    input [15:0] sw,
    input btnL, btnU, btnD, btnR, btnC,
    output [15:0] led
    );

    wire [3:0] demuxIn;

    ternary_4_mux tmux (
        .Sel({btnU, btnL}),
        .CEO(sw[3:0]),
        .You(sw[7:4]),
        .Fred(sw[11:8]),
        .Jill(sw[15:12]),
        .Enable(btnC),
        .person(demuxIn)
    );

    demux dmux (
        .In(demuxIn),
        .Sel({btnR, btnD}),
        .Enable(btnC),
        .local_lib(led[3:0]),
        .fire_department(led[7:4]),
        .school(led[11:8]),
        .rib_shack(led[15:12])
    );

endmodule
