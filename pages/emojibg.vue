<script setup lang="ts">
import { gsap, random } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { CustomEase } from "gsap/CustomEase";
import * as THREE from "three";
import particleFragment from "assets/shaders/particleFragment.glsl?raw";
import particleVertex from "assets/shaders/particleVertex.glsl?raw";
import GUI from "lil-gui";

gsap.registerPlugin(ScrollTrigger, CustomEase);

const emojiBgCanvas = ref();
const starMaterial: any = ref([]);
onMounted(() => {
  emojiBackground();
});

function emojiBackground() {
  // Scene
  const scene = new THREE.Scene(); //建立場景

  const textureLoader = new THREE.TextureLoader();
  const handTexture = textureLoader.load("/hand.png");
  const purplePlanetTexture = textureLoader.load("/purple-planet.png");
  const etsmileTexture = textureLoader.load("/etsmile.png");
  const starTexture = textureLoader.load("/star.png");

  const starGeometry = new THREE.PlaneGeometry(0.075, 0.075);
  var starArr = [];
  for (let i = 0; i < 15; i++) {
    const starMaterial = new THREE.MeshBasicMaterial({ map: starTexture, transparent: true });
    const star = new THREE.Mesh(starGeometry, starMaterial);
    starArr.push(star);
    scene.add(star);
    star.position.x = Math.random() * 6 - 4;
    star.position.y = Math.random() * 3 - 2;
    star.position.z = Math.random() * 0.5 + 5;
    star.material.opacity = 0;
  }

  for (let i = 0; i < starArr.length; i++) {
    gsap.fromTo(
      starArr[i].material,
      {
        opacity: 0,
      },
      {
        duration: 2,
        delay: "random(0,5)",
        opacity: 1,
        repeat: -1,
        repeatRefresh: true,
      }
    );
  }

  // const gui = new GUI();
  //2.8to-2.8
  // gui.add(star.position, "x").min(-5).max(5).step(0.01);
  // //1.5to-1.5
  // gui.add(star.position, "y").min(-5).max(5).step(0.01);
  // //5 - 5.5
  // gui.add(star.position, "z").min(4.5).max(5.9).step(0.01);
  // // star.material.opacity = 0.1;
  // gui.add(star.material, "opacity").min(0).max(1).step(0.01);

  // Object
  const geometry = new THREE.PlaneGeometry(0.1, 0.1);
  // const material = new THREE.MeshBasicMaterial({ color: 0xff0000 });
  const material = new THREE.RawShaderMaterial({
    vertexShader: particleVertex,
    fragmentShader: particleFragment,
    transparent: true,
    uniforms: {
      uTexture: { value: handTexture },
    },
  });
  const purplePlanetMaterial = new THREE.RawShaderMaterial({
    vertexShader: particleVertex,
    fragmentShader: particleFragment,
    transparent: true,
    uniforms: {
      uTexture: { value: purplePlanetTexture },
    },
  });
  const etsmileMaterial = new THREE.RawShaderMaterial({
    vertexShader: particleVertex,
    fragmentShader: particleFragment,
    transparent: true,
    uniforms: {
      uTexture: { value: etsmileTexture },
    },
  });

  var arr = [];
  for (let i = 0; i < 12; i++) {
    const mesh = new THREE.Mesh(geometry, material);
    const purplePlanet = new THREE.Mesh(geometry, purplePlanetMaterial);
    const etsmile = new THREE.Mesh(geometry, etsmileMaterial);

    arr.push(mesh, purplePlanet, etsmile);

    scene.add(mesh, purplePlanet, etsmile);
  }

  for (let i = 0; i < arr.length; i++) {
    gsap.fromTo(
      arr[i].position,
      { x: "random(-0.25,0.25)", z: 4.9, y: "random(-0.25,0.25)" },
      {
        delay: "random(0,10)",
        z: 6,
        x: "random(-2,2)",
        y: "random(-0.5,0.5)",
        ease: "Power2.easeIn",
        duration: 5,
        repeat: -1,
        repeatRefresh: true,
      }
    );
  }

  // Sizes
  const sizes = {
    width: window.innerWidth,
    height: window.innerHeight,
  };

  // Camera
  const camera = new THREE.PerspectiveCamera(120, sizes.width / sizes.height, 0.1, 1);

  camera.position.z = 6;
  scene.add(camera);

  // Renderer
  const renderer = new THREE.WebGLRenderer({
    canvas: emojiBgCanvas.value,
    // alpha: true,
    antialias: true,
  });
  renderer.setSize(sizes.width, sizes.height);

  // Animate
  const tick = () => {
    // Render
    renderer.render(scene, camera);
  };

  window.addEventListener("resize", () => {
    //Controls
    // Update sizes
    // orbitControl.update();
    sizes.width = window.innerWidth;
    sizes.height = window.innerHeight;
    // Update renderer
    renderer.setSize(sizes.width, sizes.height);
    // Update camera
    camera.aspect = sizes.width / sizes.height; //這個值是預防圖像扭曲
    camera.updateProjectionMatrix(); //然後執行這個來更新camera內部數值
  });
  renderer.setAnimationLoop(tick);
}
</script>

<template>
  <canvas ref="emojiBgCanvas"></canvas>
</template>
<style></style>
