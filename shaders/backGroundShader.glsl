// Kristin Bäck, kriba265
//Linköpings University
//Course: TNM084, Procedural Images and Textures
precision mediump float;


varying vec3 worldCoord;
varying vec3 iceNormal;
varying vec3 vUv;

void main()
{

  vec4 finalPos = modelMatrix * vec4(worldCoord, 1.0);

  float finalNoise = snoise(vec3(finalPos.x, 2.0*finalPos.y, finalPos.z));
  vUv = position + normal * finalNoise;

  worldCoord = position;
  iceNormal = normal;

  gl_Position = projectionMatrix * viewMatrix ; //* vec4(vUv,1.0)  ;

}
