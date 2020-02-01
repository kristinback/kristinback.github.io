// Kristin Bäck, kriba265
//Linköpings University
//Course: TNM084, Procedural Images and Textures

precision mediump float;


varying vec3 worldCoord;
varying vec3 iceNormal;

uniform vec3 light;


/***********************************************************/
vec4 iceColor(vec3 p)
{
  float noise = 0.0;
  vec4 darkIce  = vec4(0.9372549, 0.98039216, 1.0, 1.0);
  vec4 lightIce = vec4(1.0, 1.0, 1.0, 1.0);

  noise += snoise( vec3( (worldCoord.x*30.0), worldCoord.y, (worldCoord.z*3.0))*200.0 );
  //noise += snoise( vec3( (worldCoord.x/1.0), worldCoord.y, (worldCoord.z/1.0)) )*10.5 + 0.8;

  vec4 finalIce = mix(darkIce*noise*2.0, lightIce*noise, 0.3);

  return finalIce;
}
/***********************************************************/
void main()
{
  vec4 finalColor, finalIce;
  vec4 darkIce  = vec4(0.9372549, 0.98039216, 1.0, 1.0);

  finalIce = iceColor(worldCoord);
  finalColor = finalIce;
  gl_FragColor = 2.0*finalColor;



}
