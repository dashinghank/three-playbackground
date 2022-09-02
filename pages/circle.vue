<script setup lang="ts">
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { CustomEase } from "gsap/CustomEase";
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";

gsap.registerPlugin(ScrollTrigger, CustomEase);

const myCanvas = ref();
onMounted(() => {
  emojiBackground();
});

function emojiBackground() {
  // Scene
  const scene = new THREE.Scene(); //建立場景

  const textureLoader = new THREE.TextureLoader();
  const gridTexture = textureLoader.load("/bg-service-pc.png");

  const geometry2 = new THREE.RingGeometry(1, 5, 32);

  const material2 = new THREE.MeshBasicMaterial({ map: gridTexture, color: "red", side: THREE.DoubleSide });
  const mesh2 = new THREE.Mesh(geometry2, material2);
  scene.add(mesh2);

  // // Object
  // const geometry = new THREE.CircleGeometry(30, 80, 0, 2 * Math.PI);
  // // const material = new THREE.MeshBasicMaterial({ color: 0xff0000 });
  // const material = new THREE.MeshBasicMaterial({ color: "#d8dbf0", wireframe: true });

  // // Mesh
  // const mesh = new THREE.Mesh(geometry, material);

  // scene.add(mesh);

  // Sizes
  const sizes = {
    width: window.innerWidth,
    height: window.innerHeight,
  };
  console.log(sizes);

  // Camera
  const camera = new THREE.PerspectiveCamera(120, sizes.width / sizes.height);

  camera.near = 0.1;
  camera.far = 1000;
  camera.position.z = 6;

  scene.add(camera);

  // Renderer
  const renderer = new THREE.WebGLRenderer({
    canvas: myCanvas.value,
    antialias: true,
  });
  renderer.setSize(sizes.width, sizes.height);

  // Control

  const orbitControl = new OrbitControls(camera, myCanvas.value);
  //以下為最簡短操作需求

  // Animate
  const tick = () => {
    // Render
    renderer.render(scene, camera);
  };

  window.addEventListener("resize", () => {
    //Controls
    // Update sizes
    orbitControl.update();
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
  <canvas ref="myCanvas"></canvas>
</template>
<style></style>
