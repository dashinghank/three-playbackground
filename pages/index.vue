<script setup lang="ts">
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { CustomEase } from "gsap/CustomEase";
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";
import test from "node:test";
// import cursor from "../assets/css/imgs/mouse-normal.png";
// import testcursor from "../public/mouse-normal.png";

gsap.registerPlugin(ScrollTrigger, CustomEase);

const myCanvas = ref();
const tsRef = ref();
const btn = ref();
const btnSwipe = ref();
onMounted(() => {
  emojiBackground();
});

function center() {
  gsap.to(".center", {
    transformOrigin: "center center",
    scale: 0.95,
    ease: "Power2.easeIn",
    scrollTrigger: {
      trigger: ".footer-tri",
      start: "top bottom",
      end: "bottom bottom",
      scrub: 1,
      pin: ".center",
    },
  });
  gsap.to(".center", {
    scrollTrigger: {
      trigger: ".footer-tri",
      start: "top bottom",
      end: "bottom bottom",
      toggleActions: "play none none reverse",
    },
    borderRadius: "40px",
    ease: "power2.easeIn",
    // "play", "pause", "resume", "reset", "restart", "complete", "reverse", and "none".
  });
}
function positionaware() {
  // btn.value.on("mouseenter");

  btn.value.addEventListener("mousemove", (event) => {
    gsap.to(".myspan", {
      left: event.clientX - btn.value.offsetLeft - 150,
      top: event.clientY - btn.value.offsetTop - 100,
    });
  });

  btn.value.addEventListener("mouseleave", (e) => {
    console.log("mouseout");
    gsap.to(".myspan", {
      left: e.clientX - btn.value.offsetLeft - 150,
      top: e.clientY - btn.value.offsetTop - 100,
      scale: 0,
      duration: 0.6,
      ease: "power2.inout",
    });
  });

  btn.value.addEventListener("mouseover", (e) => {
    console.log("mouseover");
    gsap.to(".myspan", {
      duration: 0.6,
      scale: 1.5,
      ease: "power2.inout",
    });
  });
}

function animateSwipeBtn() {
  btnSwipe.value.addEventListener("mouseleave", (e) => {
    console.log("mouseout");
    gsap.to(".swipe-span", {
      scaleX: 0,
      duration: 0.4,
      ease: "power2.inout",
    });
  });

  btnSwipe.value.addEventListener("mouseover", (e) => {
    console.log("mouseover");
    gsap.to(".swipe-span", {
      scaleX: 1,
      duration: 0.4,
      ease: "power2.inout",
    });
  });
}

function testblock() {}

function marquee() {
  gsap.to(".front", {
    x: -1000,

    ease: "power2.inout",
    scrollTrigger: {
      trigger: ".mar-tri",
      start: "top bottom",
      end: "bottom center",
      scrub: 3,
    },
  });
  gsap.to(".back", {
    x: 1000,
    duration: 5,
    ease: "power2.inout",
    scrollTrigger: {
      trigger: ".mar-tri",
      start: "top bottom",
      end: "bottom center",
      scrub: 3,
    },
  });
}

function animtePolygon() {
  gsap.to(".polygon-star", {
    rotate: 36000,
    duration: 9999,
    repeat: -1,
  });
  CustomEase.create("custom", "M0,0 C0,0 0.066,0.366 0.2,0.5 0.351,0.651 0.627,0.614 0.8,0.7 0.964,0.781 1,1 1,1 ");
  gsap.to(".polygon-arrow", {
    y: 189,
    duration: 1.5,
    ease: "custom",
    repeat: -1,
    onComplete: () => {
      gsap.set(".polygon-arrow", { y: 0 });
      gsap.to(".polygon-arrow-back", {
        duration: 1.5,
        ease: "custom",
        y: 189,
        onComplete: () => {
          gsap.set(".polygon-arrow-back", { y: 0 });
          gsap.to(".polygon-arrow", {
            y: 189,
            duration: 1.5,
            ease: "custom",
            onComplete: () => {
              gsap.to(".polygon-arrow-back", {
                duration: 1.5,
                ease: "custom",
                y: 189,
                onComplete: () => {
                  gsap.set(".polygon-arrow-back", { y: 0 });
                },
              });
              gsap.set(".polygon-arrow", { y: 0 });
            },
          });
        },
      });
    },
  });
}

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
  const material = new THREE.MeshBasicMaterial({ map: handTexture });
  const purplePlanetMaterial = new THREE.MeshBasicMaterial({ map: purplePlanetTexture });
  const etsmileMaterial = new THREE.MeshBasicMaterial({ map: etsmileTexture });
  // Mesh
  const mesh = new THREE.Mesh(geometry, material);
  const purplePlanet = new THREE.Mesh(geometry, purplePlanetMaterial);
  const etsmile = new THREE.Mesh(geometry, etsmileMaterial);
  mesh.position.x = 0.25;
  mesh.position.z = 5;
  purplePlanet.position.x = 0.25;
  purplePlanet.position.z = 5;
  etsmile.position.x = 0.25;
  etsmile.position.z = 5;
  const arr = [mesh, purplePlanet, etsmile];

  const testtt = () => {
    for (let i = 0; i < arr.length; i++) {
      gsap.to(arr[i].position, {
        z: 6,
        x: Math.random(),
        ease: "power2.out",
        duration: 3,
        onComplete: () => {
          gsap.set(arr[i].position, { x: 0.25, z: 5 });
          testtt();
        },
      });
    }
  };
  testtt();

  scene.add(mesh, purplePlanet, etsmile);

  // Sizes
  const sizes = {
    width: window.innerWidth,
    height: window.innerHeight,
  };
  console.log(sizes);

  // Camera
  const camera = new THREE.PerspectiveCamera(120, sizes.width / sizes.height);

  const directionalLightCameraHelper = new THREE.CameraHelper(camera);
  scene.add(directionalLightCameraHelper);

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
  <!-- <div class="bg-black relative">
    <div class="bg-white w-full center relative">
      <div class="">
        <div class="h-[1000px]">
          <p class="mx-auto w-fit">aaa</p>
        </div>
        <div class="h-[1000px]">
          <p class="mx-auto w-fit">bbb</p>
        </div>
        <div class="h-[1000px]">
          <p class="mx-auto w-fit">ccc</p>
        </div>
        <div class="h-[1000px]">
          <p class="mx-auto w-fit">ddd</p>
        </div>
      </div>
    </div>
    <div class="footer-tri w-full h-[1000px]">eeee</div>
  </div> -->

  <!-- <div class="flex justify-center bg-gray-700 p-10 h-screen items-center">
    <
    <img ref="tsRef" class="ts w-8 h-8 fixed top-0 left-0" src="~assets/css/imgs/mouse-normal.png" />
    <button ref="btn" class="text-[#D3E741] rounded-3xl border-[1px] border-[#D3E741] py-7 px-24 relative w-fit h-fit overflow-hidden">
      <span class="myspan w-[300px] h-[300px] absolute top-0 left-0 scale-0 origin-center rounded-full" style="background: linear-gradient(90deg, #d3e741 2.04%, #ffffff 96.94%)"></span>
    </button>
    <button ref="btnSwipe" class="text-[#D3E741] rounded-3xl border-[1px] border-[#D3E741] py-7 px-24 relative w-fit h-fit overflow-hidden">
      <span class="swipe-span w-full h-full absolute scale-x-0 top-0 left-0 origin-left" style="background: linear-gradient(90deg, #d3e741 2.04%, #ffffff 96.94%)"></span>
    </button>
  </div> -->

  <!-- //跑馬燈動畫 -->
  <!-- <div class="bg-white">
    <div class="h-screen">g</div>
    <div class="">
      <div class="text-8xl w-full h-fit overflow-hidden py-20 mar-tri text-white skew-y-[4.9deg] bg-[#30312D]" style="font-family: dgo">
        <div class="overflow-hidden border-b-[1px] border-white">
          <div class="front flex whitespace-nowrap gap-12 py-10 items-center">
            <p>What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
            <p>What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
            <p>What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
          </div>
        </div>

        <div class="overflow-hidden border-b-[1px] border-white">
          <div class="back justify-end flex whitespace-nowrap gap-12 py-10 items-center">
            <p>We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />
            <p>We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />
            <p>We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />
          </div>
        </div>

        <div class="overflow-hidden border-b-[1px] border-white">
          <div class="back justify-end flex whitespace-nowrap gap-12 py-10 items-center">
            <p>We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />
            <p>We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />
            <p>We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />
          </div>
        </div>

        <div class="overflow-hidden border-b-[1px] border-white">
          <div class="front flex whitespace-nowrap gap-12 py-10 items-center">
            <p>Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
            <p>Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
            <p>Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
          </div>
        </div>
        <div class="overflow-hidden border-b-[1px] border-white">
          <div class="front flex whitespace-nowrap gap-12 py-10 items-center">
            <p>What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
            <p>What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
            <p>What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">What are you wating for?</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-7pupu-150.png" />
          </div>
        </div>

        <div class="overflow-hidden border-b-[1px] border-white">
          <div class="back justify-end flex whitespace-nowrap gap-12 py-10 items-center">
            <p>We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />
            <p>We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />
            <p>We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We don’t work for you</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-qq-150.png" />
          </div>
        </div>

        <div class="overflow-hidden border-b-[1px] border-white">
          <div class="back justify-end flex whitespace-nowrap gap-12 py-10 items-center">
            <p>We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />
            <p>We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />
            <p>We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />

            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">We work with you !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-love-150.png" />
          </div>
        </div>

        <div class="overflow-hidden border-b-[1px] border-white">
          <div class="front flex whitespace-nowrap gap-12 py-10 items-center">
            <p>Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
            <p>Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
            <p>Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
            <p class="text-[#30312D]" style="text-stroke: 1px #ffffff; -webkit-text-stroke: 1px #ffffff">Contact us now !</p>
            <img class="w-[120px]" src="~assets/imgs/emoji-heart-150.png" />
          </div>
        </div>
      </div>
    </div>
  </div> -->

  <!-- 八邊形動畫 -->
  <!-- <div class="p-24">
    <div class="w-[169px] flex justify-center relative overflow-hidden p-5">

      <svg class="polygon-star" viewBox="0 0 129 129" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path
          d="M89.8646 3.76639C91.1378 2.74635 93.031 3.59785 93.1125 5.22728L94.4877 32.696C94.5858 34.6567 96.0924 36.2563 98.0437 36.4718L125.381 39.4903C127.002 39.6694 127.739 41.6101 126.644 42.82L108.193 63.2156C106.876 64.6715 106.81 66.8679 108.038 68.4L125.234 89.8646C126.254 91.1378 125.402 93.031 123.773 93.1125L96.3041 94.4877C94.3434 94.5858 92.7437 96.0924 92.5282 98.0437L89.5097 125.381C89.3307 127.002 87.3899 127.739 86.1801 126.644L65.7844 108.193C64.3286 106.876 62.1321 106.81 60.6 108.038L39.1355 125.234C37.8622 126.254 35.9691 125.402 35.8875 123.773L34.5124 96.304C34.4142 94.3434 32.9077 92.7437 30.9564 92.5282L3.61942 89.5097C1.9978 89.3307 1.26126 87.3899 2.35576 86.1801L20.8067 65.7844C22.1237 64.3286 22.1896 62.1321 20.9621 60.6L3.7664 39.1355C2.74636 37.8622 3.59786 35.9691 5.22729 35.8875L32.696 34.5123C34.6567 34.4142 36.2564 32.9077 36.4718 30.9564L39.4903 3.61941C39.6694 1.9978 41.6101 1.26126 42.82 2.35576L63.2156 20.8067C64.6715 22.1237 66.8679 22.1896 68.4 20.9621L89.8646 3.76639Z"
          stroke="#D3E741"
          stroke-width="2"
        />
      </svg>
      <div class="w-[27px] absolute top-[-75px] polygon-arrow">
        <svg viewBox="0 0 27 48" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M13.5124 1.10547V47.2874C12.2738 43.1292 8.20411 35.0253 1.8342 35.8746" stroke="#D3E741" stroke-width="2" stroke-linecap="round" />
          <path d="M13.7778 1.10547V47.2874C15.0164 43.1292 19.0861 35.0253 25.456 35.8746" stroke="#D3E741" stroke-width="2" stroke-linecap="round" />
        </svg>
      </div>
      <div class="w-[27px] absolute top-[-75px] polygon-arrow-back">
        <svg viewBox="0 0 27 48" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M13.5124 1.10547V47.2874C12.2738 43.1292 8.20411 35.0253 1.8342 35.8746" stroke="#D3E741" stroke-width="2" stroke-linecap="round" />
          <path d="M13.7778 1.10547V47.2874C15.0164 43.1292 19.0861 35.0253 25.456 35.8746" stroke="#D3E741" stroke-width="2" stroke-linecap="round" />
        </svg>
      </div>
    </div>
  </div> -->

  <canvas ref="myCanvas"></canvas>
</template>
<style></style>
