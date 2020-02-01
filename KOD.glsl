// Kristin Bäck, kriba265
//Linköpings University
//Course: TNM084, Procedural Images and Textures

precision mediump float;

varying vec3 worldCoord;
varying vec3 iceNormal;
varying vec3 glassNormal;


uniform float time;

float snow(vec3 p){

  float height = snoise(vec3(p.x*0.5, 500.0, p.z*0.5));
  height += snoise(vec3((p.x/20.0)*0.5, 500.0, (p.z/20.0)*0.5));

  return height*2.0;
}

float ground(vec3 p){

  vec3 newPos = vec3( p.x*0.2, p.y*120.0, p.z );
  float n;
  float noise = 0.0;


  float noise1 = 0.08 * snoise( vec3( 0.00000005*newPos.x, 0.00000005*newPos.y, 500.0 ) );
  for( float i = 1.0; i < 8.0; i += 1.0 ) {
    n = exp( i );
    noise += ( 1.0 / i * 1.5 ) * snoise( 0.0001 * p * noise1 * n );
  }
  noise *= 200.0;

  return noise;
}

void main()
{

    vec4 worldPos = modelMatrix * vec4(position, 1.0);
    worldCoord = worldPos.xyz;

    float nH = snow(worldPos.xyz*normal);
    float sGround = ground(worldPos.xyz);

    vec3 newPosition = worldPos + nH + sGround;
    gl_Position = projectionMatrix * viewMatrix * newPosition;
}
