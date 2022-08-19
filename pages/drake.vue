<script setup lang="ts">
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { CustomEase } from "gsap/CustomEase";
import * as THREE from "three";
import particleFragment from "assets/shaders/particleFragment.glsl?raw";
import particleVertex from "assets/shaders/particleVertex.glsl?raw";
gsap.registerPlugin(ScrollTrigger, CustomEase);

const myCanvas = ref();
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
  for (let i = 0; i < 15; i++) {
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
    canvas: myCanvas.value,
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
  <canvas ref="myCanvas"></canvas>
</template>
<style></style>
