(require '[cljs.build.api :as b])

(b/watch "src"
  {:main 'the-sound-of-telephony.core
   :output-to "out/the_sound_of_telephony.js"
   :output-dir "out"})
