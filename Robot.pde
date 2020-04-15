class Robot extends Enemy{
	// Requirement #5: Complete Dinosaur Class
  float speed = 2f;
  int row=int(y/h);

	final int PLAYER_DETECT_RANGE_ROW = 2;
	final int LASER_COOLDOWN = 180;
	final int HAND_OFFSET_Y = 37;
	final int HAND_OFFSET_X_FORWARD = 64;
	final int HAND_OFFSET_X_BACKWARD = 16;
  int counter = LASER_COOLDOWN;

  Laser laser;

  Robot(float x, float y){
    super(x, y);
    laser = new Laser();
  }

  void display(){
    int direction = (speed > 0) ? RIGHT : LEFT; 
    pushMatrix();
    translate(x, y);
    if (direction == RIGHT) {
      scale(1, 1);
      image(robot, 0, 0); 
    } else {
      scale(-1, 1);
      image(robot, -w, 0); 
    }
    popMatrix();
    laser.display();  
  }
  
  void update(){
    boolean checkX = (speed > 0 && player.x + player.w/2 >this.x + HAND_OFFSET_X_FORWARD) || (speed < 0 && player.x + player.w/2 <this.x + HAND_OFFSET_X_BACKWARD);
    boolean checkY = (abs(int(y/h)-player.row) <= PLAYER_DETECT_RANGE_ROW );
    if(checkX && checkY){
      x+=0;
      laser.update();
      if(counter == 0){
        if(x + HAND_OFFSET_X_FORWARD < player.x + player.w/2){
          laser.fire(x+ HAND_OFFSET_X_FORWARD,  y +HAND_OFFSET_Y , (player.x + player.w/2) , (player.y + player.h/2));
        }else{
          laser.fire(x+HAND_OFFSET_X_BACKWARD , y +HAND_OFFSET_Y , (player.x + player.w/2) , (player.y + player.h/2));
        }
        counter = LASER_COOLDOWN;
      }else{
        laser.update(); 
        laser.display();
        counter--;
      }
      }else{
        x += speed;
        if(x < 0 || x > width - w){
          speed *= -1 ;
        }
      }
    
  }
      
  void checkCollision(Player player){
    super.checkCollision(player);
    laser.checkCollision(player);
  }
  
	// HINT: Player Detection in update()
	/*

	boolean checkX = ( Is facing forward AND player's center point is in front of my hand point )
					OR ( Is facing backward AND player's center point (x + w/2) is in front of my hand point )

	boolean checkY = player is less than (or equal to) 2 rows higher or lower than me

	if(checkX AND checkY){
		Is laser's cooldown ready?
			True  > Fire laser from my hand!
			False > Don't do anything
	}else{
		Keep moving!
	}

	*/
}
