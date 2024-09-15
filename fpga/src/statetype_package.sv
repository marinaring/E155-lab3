/*
	Marina Ring, mring@hmc.edu, 9/13/2024
	Package to store special statetype. Using this statetype allows the code to be more readable.
*/

package statetype_package;
	// define variable type for state
	typedef enum logic [4:0] {R0, R1, R2, R3, RC0, RC1, RC2, RC3, D0, D1, D2, D3, P0, P1, P2, P3, W0, W1, W2, W3} statetype;
endpackage