// ----------- Inputs -----------
// The number of pencils to hold
Pencils = 3; // [1:10]
// The diameter of the pencil
Pencil_diameter_mm = 9;
// The total width of the pocket
Pocket_width_mm = 150;
// Add extra stabilising arm the width of the pocket
Stabilizer = true;

/* [Hidden] */
// The minimum thinkness of the wall
wall_thickness_mm = 2;
height = 70;
stabilizer_height = 15;
pencil_nib_height = 20;

// Calculated Parameters
// Calculate the outer radius required for pocket holders rounded corners
o_radius = Pencil_diameter_mm/2 + wall_thickness_mm;
// Make the holes for the pencils
spacing = Pencil_diameter_mm + wall_thickness_mm;

$fn = 256;

// Test the input parameters
assert(Pencils * Pencil_diameter_mm + (2*wall_thickness_mm) <= Pocket_width_mm, "Pocket width not high enought for number of Pencils");
assert(height > pencil_nib_height, "Not tall enough to fit a pencil");


// ------- Models ----------
union(){
    difference(){
        holding_tubes();
        holes();
    };
    if (Stabilizer){
        stabilizer();
    };
};

// Create the stabilizer arm
module stabilizer() {
    hull(){
        cylinder(stabilizer_height, o_radius, o_radius);

        translate([0, Pocket_width_mm - 2*o_radius, 0]){
            cylinder(stabilizer_height, o_radius, o_radius);
        };
    };
};
 
// The pencil holding tubes
module holding_tubes () {
    hull(){
        for ( p = [0:Pencils-1]){        
            translate([0, p*spacing, 0]){
                cylinder(height, o_radius, o_radius);
            };
        };
    };
};
    
 // The holes for the pencils
module holes () {
    for ( p = [0:Pencils-1]){    
        translate([0, p*spacing, wall_thickness_mm]){
            hull(){
                // The nib protecting hole
                translate([0,0,20]){
                    cylinder(height - 20, Pencil_diameter_mm/2, Pencil_diameter_mm/2);
                }     
                // The main hole for the pencil
                cylinder(pencil_nib_height*1.2, 0, Pencil_diameter_mm/2);
            };
        };
    };
};
