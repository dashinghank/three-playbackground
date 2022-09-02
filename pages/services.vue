<script setup lang="ts">
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

import Scrollbar from "smooth-scrollbar";

gsap.registerPlugin(ScrollTrigger);
useHead({
  title: "Services",
  // or, instead:
  // titleTemplate: (title) => `My App - ${title}`,
  viewport: "width=device-width, initial-scale=1, maximum-scale=1",
  charset: "utf-8",
  meta: [{ name: "description", content: "達訊數位提供的服務" }],
  script: [{ src: "https://unpkg.com/spacingjs", async: true }],
});
const onLoadedEvents: any = inject("onLoadedEvents");

onMounted(() => {
  onLoadedEvents.value["service"] = () => {
    console.log("service init");

    initSmoothScrollbar();
    initGsapParallax();
    scaleCenter();
  };
});

function initGsapParallax() {
  gsap.to(".pc-text-wedesign", {
    y: -300,
    ease: "Power1.easeOut",
    scrollTrigger: {
      trigger: ".web-design-tri",
      start: "15% bottom",
      end: "+=200%",
      scrub: true,
    },
  });

  gsap.to(".pc-img-wedesign", {
    y: -550,
    ease: "Power1.easeOut",
    scrollTrigger: {
      trigger: ".web-design-tri",
      start: "15% bottom",
      end: "+=200%",

      scrub: true,
    },
  });
  // gsap.to(".pc-webdesign", {
  //   y: -650,
  //   ease: "Power1.easeOut",
  //   scrollTrigger: {
  //     trigger: ".web-design-tri",
  //     start: "15% bottom",
  //     end: "+=200%",
  //     scrub: true,
  //   },
  // });

  gsap.to(".pc-text-landing", {
    y: -300,
    ease: "Power1.easeOut",
    scrollTrigger: {
      trigger: ".web-landing-tri",
      start: "15% bottom",
      end: "+=200%",
      scrub: true,
    },
  });

  // gsap.to(".pc-landing", {
  //   y: -650,
  //   ease: "Power1.easeOut",
  //   scrollTrigger: {
  //     trigger: ".web-landing-tri",
  //     start: "15% bottom",
  //     end: "+=200%",
  //     scrub: true,
  //   },
  // });

  gsap.to(".pc-img-landing", {
    y: -550,
    ease: "Power1.easeOut",
    scrollTrigger: {
      trigger: ".web-landing-tri",
      start: "15% bottom",
      end: "+=200%",
      scrub: true,
    },
  });
  gsap.to(".pc-text-gm", {
    y: -300,
    ease: "Power1.easeOut",
    scrollTrigger: {
      trigger: ".web-gm-tri",
      start: "15% bottom",
      end: "+=200%",
      scrub: true,
    },
  });

  // gsap.to(".pc-gm", {
  //   y: -650,
  //   ease: "Power1.easeOut",
  //   scrollTrigger: {
  //     trigger: ".web-gm-tri",
  //     start: "15% bottom",
  //     end: "+=200%",
  //     scrub: true,
  //   },
  // });

  gsap.to(".pc-img-gm", {
    y: -550,
    ease: "Power1.easeOut",
    scrollTrigger: {
      trigger: ".web-gm-tri",
      start: "15% bottom",
      end: "+=200%",
      scrub: true,
    },
  });

  gsap.to(".pc-text-webapp", {
    y: -300,
    ease: "Power1.easeOut",
    scrollTrigger: {
      trigger: ".web-webapp-tri",
      start: "15% bottom",
      end: "+=200%",
      scrub: true,
    },
  });

  // gsap.to(".pc-webapp", {
  //   y: "-=650",
  //   ease: "Power1.easeOut",
  //   scrollTrigger: {
  //     trigger: ".web-webapp-tri",
  //     start: "15% bottom",
  //     end: "+=200%",
  //     scrub: true,
  //   },
  // });

  gsap.to(".pc-img-webapp", {
    y: -550,
    ease: "Power1.easeOut",
    scrollTrigger: {
      trigger: ".web-webapp-tri",
      start: "15% bottom",
      end: "+=200%",
      scrub: true,
    },
  });
}

function scaleCenter() {
  gsap.to(".pc-service-center", {
    scrollTrigger: {
      trigger: ".pc-service-footer-tri",
      start: "20% bottom",
      end: "bottom bottom",
      toggleActions: "play none none reverse",
    },
    duration: 0.5,
    borderRadius: "30px",
    ease: "power4.easeOut",
    // "play", "pause", "resume", "reset", "restart", "complete", "reverse", and "none".
  });
  gsap.to(".pc-service-center", {
    transformOrigin: "center center",
    scale: 0.95,
    ease: "Power2.easeIn",

    scrollTrigger: {
      trigger: ".pc-service-footer-tri",
      start: "top bottom",
      end: "bottom bottom",
      scrub: 1,
      pin: ".pc-service-center",
    },
  });
}

function initSmoothScrollbar() {
  console.log("service smooth init");
  //smooth scrollbar//
  const workScroller: any = document.querySelector(".service-scroll");
  const myScroller = Scrollbar.init(workScroller, { damping: 0.05, thumbMinSize: 100, delegateTo: document, alwaysShowTracks: false });

  ScrollTrigger.scrollerProxy(".service-scroll", {
    scrollTop(value) {
      if (arguments.length) {
        myScroller.scrollTop = value;
      }
      return myScroller.scrollTop;
    },
  });
  myScroller.addListener(({ offset }) => {
    var fixedElem = document.getElementById("bg-services-pc");

    fixedElem.style.top = offset.y + "px";
    fixedElem.style.left = offset.x + "px";
    ScrollTrigger.update();
  });
  ScrollTrigger.defaults({ scroller: workScroller });
  //smooth scrollbar//
}
</script>
<template>
  <div class="hidden 3xl:block">
    <div class="bg-[#D3E741] service-scroll h-screen relative">
      <div class="bg-white pc-service-center relative overflow-hidden">
        <img id="bg-services-pc" class="bg-services-pc w-full h-screen sticky top-0" src="~/assets/imgs/bg-service-pc.png" />
        <div class="mt-[-100vh]">
          <div class="flex justify-center text-[#6372C6] w-full h-screen items-center relative">
            <div class="absolute z-0">
              <EmojiHandShake />
            </div>

            <div class="mr-24 relative z-10 flex">
              <div class="relative z-10 self-end">
                <p style="font-family: dgo" class="text-[80px]">
                  OUR SERVICES<br />
                  MAKE YOU SEXY!
                </p>
                <p class="text-2xl leading-[36px] mt-8">
                  我們負責創造各式SEXY IDEAS並積極實現<br />
                  目的是使你的品牌充滿新奇、趣味、優雅的互動體驗
                </p>
              </div>
              <div class="pb-[300px]">
                <div class="w-72">
                  <img src="~assets/imgs/allen.png" />
                </div>
              </div>
            </div>
          </div>

          <div>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <div class="web-design-tri">
              <div class="bg-white min-h-[650px] pc-webdesign flex justify-center text-[#6372C6] mx-auto mt-36 border-[3px] border-[#6372C6] w-[1317px] items-center gap-10 py-7 px-10">
                <div class="pc-text-wedesign">
                  <p class="text-5xl" style="font-family: dgo">WEB DESIGN</p>
                  <p class="text-2xl font-black mt-6" style="font-family: arial-black">#品牌形象網站 #使用者介面<br />#網站後臺建置 #資料庫建置</p>
                  <p class="text-xl leading-[32px] mt-14">網站設計不僅只是數位化的展現，也包括品牌性的延伸，達訊<br />團隊致力於製作富含品牌視覺與互動元素的網站，使品牌在百<br />家爭鳴的線上時代也能具有強烈的識別性，使人印象深刻。</p>
                </div>
                <div class="w-[550px] pc-img-wedesign">
                  <img class="w-full" src="~assets/imgs/web-design.gif" />
                </div>
              </div>
            </div>

            <div class="web-landing-tri">
              <div class="bg-white min-h-[650px] pc-landing flex justify-center text-[#6372C6] w-[1317px] mx-auto mt-12 border-[3px] border-[#6372C6] items-center gap-10 py-7 px-10">
                <div class="w-[550px] pc-img-landing">
                  <img class="w-full" src="~assets/imgs/landing-page.gif" />
                </div>
                <div class="pc-text-landing">
                  <p class="text-5xl" style="font-family: dgo">LANDING PAGE</p>
                  <p class="text-2xl font-black mt-6" style="font-family: arial-black">#UI / UX 設計 #icon 設計<br />#動畫設計 #插圖設計</p>
                  <p class="text-xl leading-[32px] mt-14">具有強烈目的性的著陸頁頁面，有更良好的導購效果<br />，達訊團隊提供強烈識別性的著陸頁面，與流暢的使<br />用者互動體驗，能大幅增加著陸頁的導流效果，轉換<br />效果也將隨之增加。</p>
                </div>
              </div>
            </div>

            <div class="web-gm-tri">
              <div class="pc-gm bg-white min-h-[650px] flex justify-center text-[#6372C6] w-[1317px] mx-auto mt-12 border-[3px] border-[#6372C6] items-center gap-10 py-7 px-10">
                <div class="pc-text-gm">
                  <p class="text-5xl" style="font-family: dgo">GRAPHIC& MOTION</p>
                  <p class="text-2xl font-black mt-6" style="font-family: arial-black">#插圖設計 #動畫設計 #社群貼文設計<br />#廣告設計 #EMAIL設計</p>
                  <p class="text-xl leading-[32px] mt-14">隨著社群媒體的興起，圖像與動畫的觀看度與日俱增，<br />達訊團隊以擅長的動畫特效與圖像設計合併，提供不僅<br />使觀賞者驚艷的作品，也能提高品牌的關注度，創造更<br />高的使用者黏著度。</p>
                </div>
                <div class="w-[550px] pc-img-gm">
                  <img class="w-full" src="~assets/imgs/motion.gif" />
                </div>
              </div>
            </div>
            <div class="web-webapp-tri">
              <div class="pc-webapp bg-white min-h-[650px] flex justify-center text-[#6372C6] w-[1317px] mx-auto mt-12 border-[3px] border-[#6372C6] items-center gap-10 py-7 px-10">
                <div class="w-[550px] pc-img-webapp">
                  <img class="w-full" src="~assets/imgs/web-app.gif" />
                </div>
                <div class="pc-text-webapp">
                  <p class="text-5xl" style="font-family: dgo">WEB APP</p>
                  <p class="text-2xl font-black mt-6" style="font-family: arial-black">#UI / UX 設計 #報表設計 #資料庫建置<br />#多平台登陸 #API串接 #金流串接</p>
                  <p class="text-xl leading-[32px] mt-14">WEB APP 比起原生應用程式，能更快速測試產品，有更<br />多靈活運用的空間，達訊團隊也看上WEB APP不限平台<br />的多種優勢，並運用達訊團隊本身的設計強項，為客戶<br />開發客製化且富含設計感的應用程式。</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="pc-service-footer-tri">
        <DashingFooter color="#D3E741" />
      </div>
    </div>
  </div>

  <div class="hidden xl:block 3xl:hidden">
    <div class="bg-white service-scroll h-screen">
      <div class="flex justify-center mt-96 text-[#6372C6]">
        <div class="mr-24">
          <p style="font-family: dgo" class="text-6xl">
            OUR SERVICES<br />
            MAKE YOU SEXY!
          </p>
          <p class="text-xl leading-[34px] mt-8">
            我們負責創造各式SEXY IDEAS並積極實現<br />
            目的是使你的品牌充滿新奇、趣味、優雅的互動體驗
          </p>
        </div>
      </div>

      <div class="mb-20">
        <div class="flex text-[#6372C6] mx-auto mt-36 border-[3px] border-[#6372C6] w-[780px] items-center gap-10 py-7 px-10">
          <div>
            <p class="text-4xl" style="font-family: dgo">WEB DESIGN</p>
            <p class="text-sm font-black mt-3" style="font-family: arial-black">#品牌形象網站 #使用者介面 #網站後臺建置 #資料庫建置</p>
            <p class="text-sm leading-[24px] mt-14">網站設計不僅只是數位化的展現，也包括品牌性的延伸，達訊<br />團隊致力於製作富含品牌視覺與互動元素的網站，使品牌在百<br />家爭鳴的線上時代也能具有強烈的識別性，使人印象深刻。</p>
          </div>
          <div class="w-64">
            <img class="w-full" src="~assets/imgs/web-design.gif" />
          </div>
        </div>

        <div class="flex text-[#6372C6] w-[780px] mx-auto mt-12 border-[3px] border-[#6372C6] items-center gap-10 py-7 px-10">
          <div class="w-64">
            <img class="w-full" src="~assets/imgs/landing-page.gif" />
          </div>
          <div>
            <p class="text-4xl" style="font-family: dgo">LANDING PAGE</p>
            <p class="text-sm font-black mt-3" style="font-family: arial-black">#UI / UX 設計 #icon 設計 #動畫設計 #插圖設計</p>
            <p class="text-sm leading-[24px] mt-14">具有強烈目的性的著陸頁頁面，有更良好的導購效果<br />，達訊團隊提供強烈識別性的著陸頁面，與流暢的使<br />用者互動體驗，能大幅增加著陸頁的導流效果，轉換<br />效果也將隨之增加。</p>
          </div>
        </div>

        <div class="flex text-[#6372C6] w-[780px] mx-auto mt-12 border-[3px] border-[#6372C6] items-center gap-10 py-7 px-10">
          <div>
            <p class="text-4xl" style="font-family: dgo">GRAPHIC& MOTION</p>
            <p class="text-sm font-black mt-3" style="font-family: arial-black">#插圖設計 #動畫設計 #社群貼文設計 #廣告設計 #EMAIL設計</p>
            <p class="text-sm leading-[24px] mt-14">隨著社群媒體的興起，圖像與動畫的觀看度與日俱增，<br />達訊團隊以擅長的動畫特效與圖像設計合併，提供不僅<br />使觀賞者驚艷的作品，也能提高品牌的關注度，創造更<br />高的使用者黏著度。</p>
          </div>
          <div class="w-64">
            <img class="w-full" src="~assets/imgs/motion.gif" />
          </div>
        </div>

        <div class="flex text-[#6372C6] w-[780px] mx-auto mt-12 border-[3px] border-[#6372C6] items-center gap-10 py-7 px-10">
          <div class="w-64">
            <img class="w-full" src="~assets/imgs/web-app.gif" />
          </div>
          <div>
            <p class="text-4xl" style="font-family: dgo">WEB APP</p>
            <p class="text-sm font-black mt-3" style="font-family: arial-black">#UI / UX 設計 #報表設計 #資料庫建置<br />#多平台登陸 #API串接 #金流串接</p>
            <p class="text-sm leading-[24px] mt-14">WEB APP 比起原生應用程式，能更快速測試產品，有更<br />多靈活運用的空間，達訊團隊也看上WEB APP不限平台<br />的多種優勢，並運用達訊團隊本身的設計強項，為客戶<br />開發客製化且富含設計感的應用程式。</p>
          </div>
        </div>
      </div>

      <DashingFooter color="#D3E741" />
    </div>
  </div>

  <div class="hidden md:block xl:hidden">
    <div class="flex justify-center mt-96 text-[#6372C6]">
      <div class="mr-24">
        <p style="font-family: dgo" class="text-5xl">
          OUR SERVICES<br />
          MAKE YOU SEXY!
        </p>
        <p class="text-xl leading-[34px] mt-8">
          我們負責創造各式SEXY IDEAS並積極實現<br />
          目的是使你的品牌充滿新奇、趣味、優雅的互動體驗
        </p>
      </div>
    </div>
    <div class="mb-20">
      <div class="flex text-[#6372C6] mx-auto mt-36 border-[3px] border-[#6372C6] w-[700px] items-center gap-10 py-7 px-10">
        <div>
          <p class="text-2xl" style="font-family: dgo">WEB DESIGN</p>
          <p class="text-[15px] font-black mt-3" style="font-family: arial-black">#品牌形象網站 #使用者介面<br />#網站後臺建置 #資料庫建置</p>
          <p class="text-sm mt-6">網站設計不僅只是數位化的展現，也包括品牌性的延伸，達訊<br />團隊致力於製作富含品牌視覺與互動元素的網站，使品牌在百<br />家爭鳴的線上時代也能具有強烈的識別性，使人印象深刻。</p>
        </div>
        <div class="w-52">
          <img class="w-full" src="~assets/imgs/web-design.gif" />
        </div>
      </div>

      <div class="flex text-[#6372C6] w-[700px] mx-auto mt-12 border-[3px] border-[#6372C6] items-center gap-10 py-7 px-10">
        <div class="w-52">
          <img class="w-full" src="~assets/imgs/landing-page.gif" />
        </div>
        <div>
          <p class="text-2xl" style="font-family: dgo">LANDING PAGE</p>
          <p class="text-[15px] font-black mt-3" style="font-family: arial-black">#UI / UX 設計 #icon 設計<br />#動畫設計 #插圖設計</p>
          <p class="text-sm mt-6">具有強烈目的性的著陸頁頁面，有更良好的導購效果<br />，達訊團隊提供強烈識別性的著陸頁面，與流暢的使<br />用者互動體驗，能大幅增加著陸頁的導流效果，轉換<br />效果也將隨之增加。</p>
        </div>
      </div>

      <div class="flex text-[#6372C6] w-[700px] mx-auto mt-12 border-[3px] border-[#6372C6] items-center gap-10 py-7 px-10">
        <div>
          <p class="text-2xl" style="font-family: dgo">GRAPHIC& MOTION</p>
          <p class="text-[15px] font-black mt-3" style="font-family: arial-black">#插圖設計 #動畫設計 #社群貼文設計<br />#廣告設計 #EMAIL設計</p>
          <p class="text-sm mt-6">隨著社群媒體的興起，圖像與動畫的觀看度與日俱增，<br />達訊團隊以擅長的動畫特效與圖像設計合併，提供不僅<br />使觀賞者驚艷的作品，也能提高品牌的關注度，創造更<br />高的使用者黏著度。</p>
        </div>
        <div class="w-52">
          <img class="w-full" src="~assets/imgs/motion.gif" />
        </div>
      </div>

      <div class="flex text-[#6372C6] w-[700px] mx-auto mt-12 border-[3px] border-[#6372C6] items-center gap-10 py-7 px-10">
        <div class="w-52">
          <img class="w-full" src="~assets/imgs/web-app.gif" />
        </div>
        <div>
          <p class="text-2xl" style="font-family: dgo">WEB APP</p>
          <p class="text-[15px] font-black mt-3" style="font-family: arial-black">#UI / UX 設計 #報表設計 #資料庫建置<br />#多平台登陸 #API串接 #金流串接</p>
          <p class="text-sm mt-6">WEB APP 比起原生應用程式，能更快速測試產品，有更<br />多靈活運用的空間，達訊團隊也看上WEB APP不限平台<br />的多種優勢，並運用達訊團隊本身的設計強項，為客戶<br />開發客製化且富含設計感的應用程式。</p>
        </div>
      </div>
    </div>

    <DashingFooter color="#D3E741" />
  </div>

  <div class="md:hidden">
    <div class="flex justify-center mt-96 text-[#6372C6]">
      <div>
        <p style="font-family: dgo" class="w-fit text-3xl leading-[48px]">
          OUR SERVICES<br />
          MAKE YOU SEXY!
        </p>
        <p class="text-xs leading-[18px] w-fit mt-4">
          我們負責創造各式SEXY IDEAS並積極實現<br />
          目的是使你的品牌充滿新奇、趣味、優雅的互動體驗
        </p>
      </div>
    </div>

    <div class="flex justify-center mt-52 px-6">
      <div>
        <div class="border-[3px] border-[#6372C6] rounded-br-[40px] px-3 pb-9 relative w-[280px] mx-auto">
          <div class="w-64">
            <img class="w-full" src="~assets/imgs/web-design.gif" />
          </div>
          <p class="text-2xl text-[#6372C6]" style="font-family: dgo">WEB DESIGN</p>
          <p class="text-xs text-[#6372C6] font-bold mt-2">#品牌形象網站 #使用者介面 #網站後臺建置 <br />#資料庫建置</p>
          <p class="text-sm text-[#6372C6] font-bold mt-8">網站設計不僅只是數位化的展現，也包括品牌性的延伸，達訊團隊致力於製作富含品牌視覺與互動元素的網站，使品牌在百家爭鳴的線上時代也能具有強烈的識別性，使人印象深刻。</p>
        </div>

        <div class="border-[3px] border-[#6372C6] rounded-br-[40px] px-3 pb-9 mt-48 w-[280px] mx-auto">
          <div class="w-64">
            <img class="w-full" src="~assets/imgs/landing-page.gif" />
          </div>
          <p class="text-2xl text-[#6372C6]" style="font-family: dgo">LANDING PAGE</p>
          <p class="text-xs text-[#6372C6] font-bold mt-2">#UI / UX 設計 #icon 設計 #動畫設計 <br />#插圖設計</p>
        </div>

        <div class="border-[3px] border-[#6372C6] rounded-br-[40px] px-3 pb-9 mt-48 w-[280px] mx-auto">
          <div class="w-64">
            <img class="w-full" src="~assets/imgs/motion.gif" />
          </div>
          <p class="text-2xl text-[#6372C6]" style="font-family: dgo">GRAPHIC &<br />MOTION</p>
          <p class="text-xs text-[#6372C6] font-bold mt-2">
            #插圖設計 #動畫設計 #社群貼文設計<br />
            #廣告設計 #EMAIL設計
          </p>
          <p class="text-sm text-[#6372C6] font-bold mt-8">隨著社群媒體的興起，圖像與動畫的觀看度與日俱增，達訊團隊以擅長的動畫特效與圖像設計合併，提供不僅使觀賞者驚艷的作品，也能提高品牌的關注度，創造更高的使用者黏著度。</p>
        </div>
        <div class="border-[3px] border-[#6372C6] rounded-br-[40px] px-3 pb-9 mt-48 w-[280px] mx-auto">
          <div class="w-64">
            <img class="w-full" src="~assets/imgs/web-app.gif" />
          </div>
          <p class="text-2xl text-[#6372C6]" style="font-family: dgo">WEB APP</p>
          <p class="text-xs text-[#6372C6] font-bold mt-2">
            #UI / UX 設計 #報表設計 #資料庫建置<br />
            #多平台登陸 #API串接 #金流串接
          </p>
          <p class="text-sm text-[#6372C6] font-bold mt-8">Web app 比起原生應用程式，能更快速測試產品，有更多靈活運用的空間，達訊團隊也看上web app不限平台的多種優勢，並運用達訊團隊本身的設計強項，為客戶開發客製化且富含設計感的應用程式。</p>
        </div>
      </div>
    </div>
    <DashingFooter color="#D3E741" />
  </div>
</template>
