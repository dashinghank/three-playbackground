<script setup lang="ts">
import { gsap } from "gsap";
import * as THREE from "three";
// import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";

const myCanvas = ref();
onMounted(() => {
  emojiBackground();
});

function emojiBackground() {
  // Scene
  const scene = new THREE.Scene(); //建立場景

  const textureLoader = new THREE.TextureLoader();
  const handTexture = textureLoader.load("/endmap.png");
  // Object
  const geometry = new THREE.CylinderGeometry(2, 2, 0.5, 32);
  handTexture.minFilter = THREE.NearestFilter;

  const materials = [
    new THREE.MeshBasicMaterial({
      transparent: true,
      map: handTexture,
      side: THREE.DoubleSide,
    }),
    new THREE.MeshBasicMaterial({
      transparent: true,
      opacity: 0,
      side: THREE.DoubleSide,
    }),
    new THREE.MeshBasicMaterial({
      transparent: true,
      opacity: 0,
      side: THREE.DoubleSide,
    }),
  ];

  // Mesh
  const mesh = new THREE.Mesh(geometry, materials);

  const mesh2 = new THREE.Mesh(geometry, materials);
  animateLoading(mesh, mesh2);
  mesh2.position.y = 1;

  mesh2.rotation.reorder("ZXY");
  mesh2.rotation.z = -0.25;
  mesh2.rotation.x = -0.25;

  mesh.rotation.reorder("ZXY");
  mesh.rotation.z = -0.25;
  mesh.rotation.x = -0.25;

  scene.add(mesh, mesh2);

  // Sizes
  const sizes = {
    width: window.innerWidth,
    height: window.innerHeight,
  };
  console.log(sizes);

  // Camera
  const camera = new THREE.PerspectiveCamera(120, sizes.width / sizes.height);

  camera.near = -10;
  camera.far = 10000;
  camera.position.z = 5;

  scene.add(camera);

  // Renderer
  const renderer = new THREE.WebGLRenderer({
    canvas: myCanvas.value,
    antialias: true,
  });
  renderer.setSize(sizes.width, sizes.height);

  // Control

  // const orbitControl = new OrbitControls(camera, myCanvas.value);
  //以下為最簡短操作需求

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

function animateLoading(mesh, mesh2) {
  console.log("document.body:", document.body);
  document.body.style.overflow = "hidden";
  gsap.to(mesh.rotation, {
    x: 1,
    duration: 2,
    repeat: -1,
  });

  gsap.to(mesh.rotation, {
    y: 50,
    duration: 25,
    ease: "none",
    repeat: -1,
  });
  gsap
    .to(mesh.rotation, {
      x: 0.25,
      duration: 2,
      yoyo: true,
      repeat: -1,
    })
    .progress(0.5);
  gsap.to(mesh.rotation, {
    z: 0.25,
    duration: 2,
    yoyo: true,
    repeat: -1,
  });

  gsap.to(mesh2.rotation, {
    y: 50,
    duration: 70,
    repeat: -1,
    ease: "none",
  });
  gsap
    .to(mesh2.rotation, {
      x: 0.25,
      duration: 2,
      yoyo: true,
      repeat: -1,
    })
    .progress(0.5);
  gsap.to(mesh2.rotation, {
    z: 0.25,
    duration: 2,
    yoyo: true,
    repeat: -1,
  });
}
</script>

<template>
  <div class="z-50 fixed top-0 w-screen h-screen">
    <canvas class="w-full h-full" ref="myCanvas"></canvas>
  </div>
</template>
<style></style>
