$fn=100;
dim_base_x = 77;
dim_base_y = 15;
dim_base_z = 99.5;
dim_y_elips = 20;


difference()
{
    union()
    {
    cube([dim_base_x, dim_base_y, dim_base_z]);

    translate([dim_base_x/2,0,0])
        resize([77,5*2,dim_base_z])
        cylinder(dim_base_z, d=dim_base_x);
    }

    wall_width = 1.5;
    translate([wall_width, wall_width, wall_width])
    cube([dim_base_x-2*wall_width, dim_base_y, dim_base_z-2*wall_width]);


    x1= dim_base_x/2 - 40/2;
    x2= dim_base_x/2 + 40/2;
    for (x=[x1,x2])
    {
        translate([x,dim_base_y/2,0])
        {
            cylinder(dim_base_z,d=2.8);
        }
    }

}
