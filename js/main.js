//Kristin Bäck, kriba265
//Linköpings University
//Course: TNM084, Procedural Images and Textures

require([
    "../libs/text!../shaders/vertexShader.glsl",
    "../libs/text!../shaders/fragmentShader.glsl",
    "../libs/text!../shaders/simplex-noise-3d.glsl",
    "../libs/text!../shaders/cellular3D.glsl",
    "../libs/text!../shaders/classicnoise3D.glsl",
    //"../libs/text!../shaders/backGroundShader.glsl",
    "../libs/text!../shaders/backFragShader.glsl",
    "../libs/orbit-controls"
],

function (
    vertexShader,
    fragmentShader,
    sNoise,
    cellNoise,
    perlinNoise,
    bVShader,
    backColor)
{
    "use strict";

    var scene = new THREE.Scene();
		var camera = new THREE.PerspectiveCamera( 10, window.innerWidth/window.innerHeight, 100, 1000000 );
    camera.position.set(0, 0, 10000);


		var renderer = new THREE.WebGLRenderer();
		renderer.setSize( window.innerWidth, window.innerHeight );
    renderer.setClearColor( 0xa8bbc3);//a8bbc7 )  //backgound color!!
		document.body.appendChild( renderer.domElement );

    var controls = new THREE.OrbitControls(camera, renderer.domElement);

    var pointLight = new THREE.PointLight(0x00ff00);
    pointLight.position.set(1000,0,0);
    //pointLight.rotation.set(Math.PI/2, Math.PI/6, 0);
    scene.add( pointLight );

    var fragUniforms = {
          light: { type: 'v3', value: pointLight.position },
          //time: {type: "f", value: 1.0},
    };

    /* ICE */
    var iceGeometry = new THREE.PlaneBufferGeometry(10000, 5000, 8000, 200);
    var iceMaterial = new THREE.ShaderMaterial( {
      side: THREE.DoubleSide,
      transparent: true,
      opacity:0.8,
      uniforms: fragUniforms,
      vertexShader:  sNoise + vertexShader,
      fragmentShader: sNoise + fragmentShader
      } );
    var ice = new THREE.Mesh( iceGeometry, iceMaterial );
    ice.position.set(0, 10, 0);
    //ice.rotation.x = Math.PI/2;
    scene.add( ice );


    /* BACKGROUND SPHERE */
    // var geometry = new THREE.SphereGeometry( 100, 100, 100 );
    // var material = new THREE.MeshBasicMaterial( {
    //   color: 0xf2f2f2
    // } );
    // var sphere = new THREE.Mesh( geometry, material );//iceMaterial
    // sphere.position.set(0, 0, -300);
    // scene.add( sphere );


    /* WINDOW */
    var windowGeometry = new THREE.PlaneBufferGeometry(10000, 5000, 8000, 100);
    var windowMaterial = new THREE.MeshBasicMaterial({
      side: THREE.DoubleSide,
      opacity: 0.5,
      color: 0xa8bbc7,
      transparent: true
    })
    var glassWindow = new THREE.Mesh(windowGeometry, windowMaterial);
    glassWindow.position.set(0, 50, 0);
    //glassWindow.rotation.x = Math.PI/2;
    scene.add(glassWindow);

    /* WALL */
    var wallGeometry = new THREE.PlaneBufferGeometry(10000, 9000, 100000, 100);
    var wallMaterial = new THREE.MeshBasicMaterial({
      //side: THREE.DoubleSide,
      opacity: 0.5,
      color: 0xffffff,
      transparent: true
    })
    var woodenWall = new THREE.Mesh(wallGeometry, wallMaterial);
    glassWindow.position.set(0, 50, 0);
    //glassWindow.rotation.x = Math.PI/2;
    scene.add(woodenWall);

    /* ANIMATION */
		var animate = function () {
			requestAnimationFrame( animate );
      controls.update();
			renderer.render(scene, camera);
		};

		animate();
});
