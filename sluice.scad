/*
	/dev/sluice - (c) psicom
	config = "river" | "highbanker"
*/
sluice(130,40,15,.2, "river");

// sluiceconfig
module sluice(length, width, height, thick, config){
	color("silver"){
		union(){
			// sluice base
			sluicebase(length, width, height, thick)
			echo(config);
			if (config == "highbanker"){
				translate([0,thick,height/2]) bankerextension(length/1.5, width-thick, height*2, thick);
				venturisucker();
			}
			else{
				translate([-10,0,0]) riverextension(length/7, height/3, thick, width);
			}
		}
	}
}

// modules
module sluicebase(length, width, height, thick){	
	union(){
		difference(){
			// U form
			union(){
				cube([length,width,thick]);
				cube([length,thick,height]);
				translate([0,width,0]) cube([length,thick,height]);
			}
			// adaptorholes
			union(){	
				translate([1.2, width/10*2,-4]) cylinder(h=10, r=.8, $fn=10);
				translate([1.2, width/10*8,-4]) cylinder(h=10, r=.8, $fn=10);
			}
		}
		// handle
		translate([length/2, -5, height/2]) union(){
			cube([2,5,2]);
			translate([0,-2,0]) cube([12,2,2]);
			translate([10,0,0]) cube([2,5,2]);
		}
	}
}

module inlayandmoss(){
}

module standingfeet(){
}

module riverextension(length, height, thick, width){
	difference(){
		union(){
			cube([2, width, thick]);
			rotate([0,0,-135]) cube([length/cos(45), thick, height]);
			translate([0,width,0]) rotate([0,0,135]) cube([length/cos(45), thick, height]);
			translate([-length,0,0]){
				cube([length, width, thick]);
				mirror([0,1,0]){
					linear_extrude(height = thick, center = false, convexity = thick, twist = 0)
					polygon(points=[[0,0],[length,0],[0,length]], paths=[[0,1,2]]);
				}
				translate([0,width,0]){
					linear_extrude(height = thick, center = false, convexity = thick, twist = 0)
					polygon(points=[[0,0],[length,0],[0,length]], paths=[[0,1,2]]);
				}
			}
		}
		// adaptorholes
		union(){	
				translate([1, width/10*2,-4]) cylinder(h=10, r=.8, $fn=10);
				translate([1, width/10*8,-4]) cylinder(h=10, r=.8, $fn=10);
		}
	}
}

module bankerextension(length, width, height, thick, hole){
	rotate(a=30, v=[0,-1,0]) {
		translate([0,0,0]) {
			color("silver"){
				union(){
					union(){
						// backplane
						translate([0,0,height/3]) cube([thick, width, height/3*2]);
						// oberer Boden
						translate([length/2,0,0]){
							cube([length/2,width,thick]);
							translate([0,0,height/2]){
								difference(){
   								cube([thick, width, height/2]);
   								rotate ([0,90,0]) translate([-height/4,width/2,-0.01]) 
										cylinder ( h = thick+0.02, r=3, $fn=100);
								}
							}
						}
					}
					cube([length,thick,height]);
					translate([0,width,0]) cube([length,thick,height]);
					translate([length,0,0]) cube([thick, width, height]);
				}
				// grid
				for (x = [0 : 4 : 40]){
    				translate([x, 0, 0])	cube([2, width, thick]);
				}
			}
		}
	}
}

module venturisucker(){

}


// helperfoo

module prism(l, w, h) {
	translate([0, l, 0]) rotate( a= [90, 0, 0])
	linear_extrude(height = l) polygon(points = [
		[0, 0],
		[w, 0],
		[0, h]], paths=[[0,1,2,0]]);
}
