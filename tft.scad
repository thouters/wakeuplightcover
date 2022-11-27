$fn=100;

tft_pcb_thickness = 1.86;
module tft_mounting_hole(nx,ny)
{
    x = nx == 0? 3: 47;
    y = ny == 0? 7: 84;
    translate([x,y,0])
        children(0);
}
module tftbore()
{
    cylinder(10,d=3,center=true);
}
module mountbore(l=40)
{
    translate([0,0,0])
    cylinder(l,d=2.7,center=true);
}
module tft(aperture_drill=0)
{
    pcb_y = 86;
    pcb_x = 50;
    difference()
    {
        translate([0,0,-aperture_drill])
        cube([pcb_x, pcb_y, tft_pcb_thickness+aperture_drill]);
        if (aperture_drill==0)
        {
            for(i=[[0,0],[0,1],[1,0],[1,1]])
            {
                tft_mounting_hole(i[0], i[1])
                    tftbore();
            }
        }
    }

    //tft
    tft_y=70;
    tft_z = 7;
    border = 3;
    translate([0,10, tft_pcb_thickness])
        cube([pcb_x,tft_y, tft_z-tft_pcb_thickness]);

    translate([5,0, tft_pcb_thickness])
        cube([pcb_x-10,tft_y, tft_z-tft_pcb_thickness]);

    translate([border, border+15, tft_pcb_thickness])
        cube([pcb_x-border*2,
            tft_y-border*2-5, 
            tft_z-tft_pcb_thickness+aperture_drill
        ]);
}

module tft_location()
{
    translate([1,1,-tft_pcb_thickness])
        children(0);

}
if(0)
difference()
{
    cube([55,90,6]);
    tft_location()
    union()
    {
        tft(100);

            for(i=[[0,0],[0,1],[1,0],[1,1]])
            {
                tft_mounting_hole(i[0], i[1])
                    mountbore(10);
            }
    }
}

if(1)
    tft_location()
    color("red")
    tft();


