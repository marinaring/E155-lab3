/*
	Marina Ring, mring@hmc.edu, 9/13/2024
	Package to store special statetype. Using this statetype allows the code to be more readable.
*/

package statetype_package;
	// define variable type for state
	typedef enum logic [3:0] {R0, R1, R2, R3, P0, P1, P2, P3, W0, W1, W2, W3} statetype;
endpackage