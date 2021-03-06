class ParticleSystem{
  
  static final float particle_radius = 15;     //Radius of particle
   ArrayList<PVector> centers;     //List of centers
   PVector origin;                 //Origin of particles
   
   ParticleSystem(PVector origin){
     this.origin = origin.copy();
     centers = new ArrayList<PVector>();
     centers.add(origin);
   }
   
    void addParticle(){ 
        PVector center;
        int num_attempts = 100;
        for(int i=0; i<num_attempts; i++) {
            int index = int(random(centers.size())); 
            center = centers.get(index).copy();
            float angle = random(TWO_PI);
            center.x += sin(angle) * 2*particle_radius; 
            center.z += cos(angle) * 2*particle_radius; 
            if(checkPosition(center)) {
           
                updateScore(false);
                centers.add(center);
                break;
            }
          } 
     }
  
     boolean checkPosition(PVector p){
         Cylinder cylinder = new Cylinder(p.x,p.y,p.z);
         ArrayList<Cylinder> cylinders = new ArrayList<Cylinder>();
         for(int i=0 ; i<centers.size();i++){
            cylinders.add(new Cylinder(centers.get(i).x,centers.get(i).y,centers.get(i).z));
         }
         return cylinder.isInPlate() && !cylinder.isOverlap(cylinders);
     }
     
     void run(){
         for(PVector v : centers){
             new Cylinder(v.x,v.y,v.z).display();
         }
     }
     
     void drawRobot(PShape rNik){
           gameSurface.pushMatrix();
           Cylinder cyl = new Cylinder(origin.x,origin.y,origin.z);
           gameSurface.translate(cyl.posC.x, cyl.posC.y-50, cyl.posC.z);
           gameSurface.scale(-30);
           gameSurface.shape(rNik);
           gameSurface.popMatrix();
     }
}
