<template>
  <div>
    <transition
      appear
      enter-active-class="animated fadeIn"
      leave-active-class="animated fadeOut"
    >
      <div>
        <q-card-section>
          <q-item>
            <q-item-section avatar>
              <q-avatar size="150px" rounded>
                <q-img :src="derby.asset.image_preview_url"/>
              </q-avatar>
            </q-item-section>
            <q-item-section>
              <q-toolbar class="q-pt-none q-pb-xs">
                <div>
                  <div class="text-dark q-mt-sm text-weight-bolder">{{ derby.asset.name }}</div>
                </div>
                <q-space/>
              </q-toolbar>
              <q-toolbar>
                <q-linear-progress style="width: 200px" rounded size="20px" :value="(derby.perfection/100)" color="blue-7">
                  <div class="absolute-full flex flex-center">
                    <q-badge color="transparent" text-color="white" :label="`perfection ${derby.perfection} %`"/>
                  </div>
                </q-linear-progress>

              </q-toolbar>
              <q-card-section>
                <div class="row q-col-gutter-sm">
                  <div  class="col">
                    <div class="bg-blue-1 text-center q-pa-sm">
                      <div class="text-weight-bold text-blue-9">Gender</div>
                      <div class="q-mt-sm">{{ derby.gender }}</div>
                    </div>

                  </div>
                  <div  class="col">
                    <div class="bg-blue-1 text-center q-pa-sm">
                      <div class="text-weight-bold text-blue-9">Heritage</div>
                      <div class="q-mt-sm">{{ derby.heritage }}</div>
                    </div>

                  </div>
                  <div  class="col">
                    <div class="bg-blue-1 text-center q-pa-sm">
                      <div class="text-weight-bold text-blue-9">Talent</div>
                      <div class="q-mt-sm">{{ derby.talent }}</div>
                    </div>

                  </div>
                  <div class="col">
                    <q-btn  color="primary" class=" q-ml-lg" outline @click="show_on_openseas(derby.asset.permalink)"
                           :label="`Buy ${price} ETH`"/>
                  </div>
                  <div class="col">
                    <div style="margin-top: 10px" class="q-ml-lg text-weight-bold">{{ created_date }}</div>
                  </div>
                </div>

              </q-card-section>
              <q-card-section class="q-pt-none">
                <div class="row q-col-gutter-sm">
                  <div  class="col">
                    <div class="bg-blue-1 text-center q-pa-sm">
                      <div class="text-weight-bold text-blue-9">Background</div>
                      <div class="q-mt-sm">{{ derby.background }}</div>
                    </div>

                  </div>
                  <div  class="col">
                    <div class="bg-blue-1 text-center q-pa-sm">
                      <div class="text-weight-bold text-blue-9">BaseBody</div>
                      <div class="q-mt-sm">{{ derby.basebody }}</div>
                    </div>

                  </div>
                  <div  class="col">
                    <div class="bg-blue-1 text-center q-pa-sm">
                      <div class="text-weight-bold text-blue-9">CombColor</div>
                      <div class="q-mt-sm">{{ derby.combcolor }}</div>
                    </div>

                  </div>
                  <div  class="col">
                    <div class="bg-blue-1 text-center q-pa-sm">
                      <div class="text-weight-bold text-blue-9">EyesType</div>
                      <div class="q-mt-sm">{{ derby.eyestype }}</div>
                    </div>

                  </div>
                  <div  class="col">
                    <div class="bg-blue-1 text-center q-pa-sm">
                      <div class="text-weight-bold text-blue-9">WattleColor</div>
                      <div class="q-mt-sm">{{ derby.wattlecolor }}</div>
                    </div>

                  </div>
                </div>
              </q-card-section>
              <q-separator spaced="" color="grey-3"/>
            </q-item-section>
          </q-item>

        </q-card-section>

      </div>
    </transition>
  </div>
</template>

<script>
import {date} from 'quasar'
import {Socket} from "phoenix-channels";

export default {
  name: "chicken_derby",
  props: {
    derby: Object
  },
  data() {
    return {
      timeStamp: Date.now(),
      socket: null,
      channel: null,
    }
  },
  computed: {
    price() {
      return this.derby.starting_price / 1000000000000000000
    },
    created_date() {
      let diffMinutes = date.getDateDiff(this.timeStamp, this.derby.created_date, 'minutes')
      let diffHours = date.getDateDiff(this.timeStamp, this.derby.created_date, 'hours')
      let formattedDate = date.formatDate(this.derby.created_date, 'Do, dd, HH: MM')
      if (diffMinutes <= 59) {
        return diffMinutes + " minutes " + "ago"
      } else if (diffMinutes > 59 && diffHours <= 12) {
        return diffHours + " hours  " + "ago"
      } else {
        return formattedDate
      }

    }
  },
  created() {
    let self = this
    setInterval(function () {
      self.timeStamp = Date.now()
    }, 1000)
  },
  methods: {
    show_on_openseas(permalink) {
      window.open(permalink, '_blank');
    }
  }
}
</script>

<style scoped>

</style>
