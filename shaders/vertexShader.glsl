// Kristin Bäck, kriba265
//Linköpings University
//Course: TNM084, Procedural Images and Textures
precision mediump float;


varying vec3 worldCoord;
varying vec3 iceNormal;
varying vec3 vUv;

float iceHeight(vec3 p){
  float height = 0.0;
  height += snoise(vec3((0.01*(p/2.0))))*4.0+4.5;

  return height*4.5;
}

float snow(vec3 p){
  //float height = snoise(vec3(p.x*0.00005, 500.0, p.z*0.00005));
  float height = snoise(vec3(p.x,p.y, 500.0 ));
  float noise = 0.0;
  noise += snoise( vec3( (p.x*10.0)/0.06, p.y, (p.z*10.0)) )* 13.290+12.298;
  noise += snoise( vec3( (p.x/10.0), p.y, (p.z/10.0)) )*10.5 + 0.8;

  return noise;
}

float ground(vec3 p){

  float noise1 = 4.5 * snoise( vec3( 0.02*p.x, 0.02*p.y, 500.0  ) );

  return noise1*4.1;
}

void main()
{

  vec4 finalPos = modelMatrix * vec4(position, 1.0);

  worldCoord = normalize(finalPos.xyz); //???

  float sIce = iceHeight(finalPos.xyz);
  float nH = snow(finalPos.xyz)*0.3;
  float sGround = ground(finalPos.xyz);

  float finalNoise = sIce + sGround;
  vUv = position + normal * finalNoise;
/*
  finalPos.y <= sIce ?
    finalPos = vec4(finalPos.x, finalPos.y*sIce*0.15, finalPos.z, 1.0) :
    finalPos;
*/

  worldCoord = position;
  iceNormal = normal;
  finalPos.z = finalNoise;

  gl_Position = projectionMatrix * viewMatrix * vec4(vUv,1.0)  ;

}
