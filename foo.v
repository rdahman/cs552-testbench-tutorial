/**
 * Author: Kyle May
 *
 * The intended truth table for this module is:
 *
 *   a  b  c | y
 *   -----------
 *   0  0  0 | 1
 *   0  0  1 | 1
 *   0  1  0 | 0
 *   0  1  1 | 0
 *   1  0  0 | 1
 *   1  0  1 | 0
 *   1  1  0 | 0
 *   1  1  1 | 0
 *
 * Determine on which inputs this implementation fails.
 */
module foo(
  input  a,
  input  b,
  input  c,
  output y
);
  
  assign y = (~b & ~c) | (a & ~b);

endmodule
