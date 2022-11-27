use <tft.scad>;
$fn=300;
dim_base_x = 77.5;
dim_base_y = 15;
dim_base_z = 99.5;
dim_y_elips = 20;

aperture_x = 50;
aperture_z = 58;

module translate_corner(i)
{
    x = i==0 ? 4 : dim_base_x-4;
    translate([x,dim_base_z/2,dim_base_z-4])
        children(0);

}
module object()
{
    difference()
    {
        union()
        {
        cube([dim_base_x, dim_base_y, dim_base_z]);

        translate([dim_base_x/2,0,0])
            resize([77,6*2,dim_base_z])
            cylinder(dim_base_z, d=dim_base_x);
        }

        wall_width = 1.5;
        translate([wall_width, wall_width, wall_width])
        cube([dim_base_x-2*wall_width, dim_base_y, dim_base_z-2*wall_width-2]);


        x1= dim_base_x/2 - 40/2;
        x2= dim_base_x/2 + 40/2;
        for (x=[x1,x2])
        {
            translate([x,dim_base_y/2,0])
            {
                cylinder(dim_base_z,d=2.8);
            }
        }

    box_x_off = (dim_base_x - aperture_x)/2;
    box_z_off = (dim_base_z - aperture_z)/2;
        
        translate([box_x_off,4,5])
        {
        //cube([aperture_x,10,aperture_z]);
            rotate([90,0,0])
            {
                tft(100);
                for(i=[[0,0],[0,1],[1,0],[1,1]])
                {
                    tft_mounting_hole(i[0], i[1])
                        mountbore(10);
                }

            }
        }
    }
}

difference()
{
   object();
   for (i=[0,1])
   {

       translate_corner(i)
       translate([0,-dim_base_z/2,0])
            cube([8,dim_base_z,8],center=true);
   }
}
intersection()
{
    object();
    union()
    {
        for (i=[0,1])
        {
            translate_corner(i)
            mirror([i,0,0])
                rotate([90,00,0])
                union()
                {
                cylinder(dim_base_z,r=4);
                cube([4,4, dim_base_z]);
                translate([0,-4,0])
                cube([4,4, dim_base_z]);
                translate([-4,-4,0])
                cube([4,4, dim_base_z]);
                }
        }
    }
}

translate([100,0,0])
cube([dim_base_x,10,10]); 
