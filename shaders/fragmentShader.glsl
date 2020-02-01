// Kristin Bäck, kriba265
//Linköpings University
//Course: TNM084, Procedural Images and Textures

precision mediump float;


varying vec3 worldCoord;
varying vec3 iceNormal;
varying vec3 vUv;

//uniform float time;
uniform vec3 light;

/***********************************************************/
vec4 iceColor(vec3 p)
{

  vec3 sLight = normalize(vec3(0.0,300.0,0.0));
  vec3 lightDir = normalize(sLight - worldCoord);
  float phong = max(dot(lightDir,iceNormal), 0.0);
  vec3 diffuseLight = vec3(1.0, 1.0, 1.0);

  float noise = 0.0;
  vec4 darkIce  = vec4(0.9372549, 0.98039216, 1.0, 1.0);
  vec4 lightIce = vec4(1.0, 1.0, 1.0, 1.0);

  noise += snoise( vec3( (p.x*3.0), (p.y*3.0), p.z ) )* 20.290+1.298;
  noise += snoise( vec3( (p.x/10.0), (p.y/10.0), p.z ))*10.5 + 0.8;

  vec4 finalIce = mix(darkIce*noise*3.0, lightIce*noise, 0.3);
  vec4 fin = vec4(finalIce.xyz + phong*diffuseLight, 0.5);
  return finalIce  + fin;
}
/***********************************************************/
vec4 snowyColor(vec3 p){
  float noise = 0.0;
  vec4 darkIce  = vec4(0.9372549, 0.98039216, 1.0, 1.0);
  vec4 lightIce = vec4(1.0, 1.0, 1.0, 1.0);

  noise += snoise( vec3( (p.x*10.0)/0.06, (p.y*10.0), p.z) )* 13.290+12.298;
  noise += snoise( vec3( (p.x/10.0), (p.y/10.0), p.z ) )*10.5 + 0.8;

  vec4 finalIce = mix(darkIce*3.0*noise, lightIce, 0.5);

  return finalIce;
}
/***********************************************************/
void main()
{
  vec4 finalColor, finalIce;


  if(vUv.z <= 16.0 && vUv.z >= 0.0 ){   // glass surface, semi snow
    finalIce = iceColor(worldCoord);
    finalColor = finalIce;
    gl_FragColor = 2.0*finalColor;
  }
  else if(vUv.z > 16.0 ){  // snow
    finalIce = snowyColor(worldCoord);
    finalColor = finalIce ;
    gl_FragColor = finalColor;
  }
  else if(vUv.z < -2.5){   // glass surface only
    vec4 color1 = vec4(0.65882353, 0.73333333, 0.78039216, 0.2);
    vec4 color2 = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 finalColor = mix(color1, color2, 0.8);
    gl_FragColor = finalColor;
  }

}
