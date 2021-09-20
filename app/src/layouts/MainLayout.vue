<template>
  <q-layout view="hHh lpR fFf">
    <q-header bordered class="bg-white">
      <q-toolbar>
        <q-space/>
        <q-btn :to="{name: 'home'}" color="dark" flat label="Home"/>
        <q-space/>
        <q-btn flat @click="drawerRight = !drawerRight" color="dark" round dense icon="menu"/>
      </q-toolbar>
    </q-header>

    <q-drawer
      side="right"
      v-model="drawerRight"
      show-if-above
      bordered
      :breakpoint="500"
      class="bg-transparent"
    >
      <q-scroll-area class="fit">
        <q-list class="rounded-borders">
          <q-expansion-item
            default-opened
            expand-separator
            label="Heritage"
          >
            <q-card>
              <q-card-section>
                <q-option-group
                  :options="heritage_options"
                  type="checkbox"
                  v-model="filters.heritage"
                />
              </q-card-section>
            </q-card>
          </q-expansion-item>

          <q-expansion-item
            default-opened
            expand-separator
            label="Talent"
          >
            <q-card>
              <q-card-section>
                <q-option-group
                  :options="talent_options"
                  type="checkbox"
                  v-model="filters.talent"
                />
              </q-card-section>
            </q-card>
          </q-expansion-item>

          <q-expansion-item
            default-opened
            expand-separator
            label="Perfection"
          >
            <q-card>
              <q-card-section>
                <q-range
                  label
                  v-model="filters.perfection"
                  :min="0"
                  :max="100"
                />
              </q-card-section>
            </q-card>
          </q-expansion-item>
        </q-list>
      </q-scroll-area>
    </q-drawer>
    <q-page-container>
      <q-page class="container">
        <q-card-section>
          <q-toolbar>
            <q-space/>
            <div class="text-h5 text-dark text-weight-bolder">
              Chicken Derby Listings
            </div>
            <q-space/>
          </q-toolbar>
        </q-card-section>
        <q-card>
          <q-separator spaced="" color="grey-3"/>
          <div v-if="$q.platform.is.mobile">
            <Chicken_derby_mobile  v-for="(derby, key) in chicken_derbies" :derby="derby" :key="key"/>
          </div>
        <div  v-else>
          <Chicken_derby v-for="(derby, key) in chicken_derbies" :derby="derby" :key="key"/>
        </div>
          <q-card-section class="flex flex-center" v-if="chicken_derbies.length === 0 && !loading_data">
            <div class="text-h6">No Items Found</div>
          </q-card-section>
          <q-inner-loading v-if="!pagination_stats.has_next" :showing="loading_data">
            <q-spinner-oval size="50px" color="primary"/>
          </q-inner-loading>
        </q-card>
        <q-card-section class="text-center" v-if="pagination_stats.has_next">
          <q-btn no-caps :loading="loading_data" @click="fetch_chicken_derbies" icon="refresh" unelevated class="bg-white" label="Load More" rounded></q-btn>
        </q-card-section>

      </q-page>
    </q-page-container>
  </q-layout>
</template>

<script>
import { Platform } from 'quasar'
import {defineComponent} from 'vue';
import Chicken_derby from "components/chicken_derby";
import {Socket} from "phoenix-channels";
import Chicken_derby_mobile from "components/chicken_derby_mobile";

export default defineComponent({
  name: 'MainLayout',
  components: {Chicken_derby_mobile, Chicken_derby},
  data() {
    return {
      socket_items_count: 0,
      chicken_runner_toggle: 'listings',
      pagination_stats: {
        count: 0,
        first: 0,
        has_next: false,
        has_prev: false,
        last: 0,
        next_page: 1,
        page: 0,
        prev_page: 0,
        limit: 10
      },
      drawerRight: false,
      filters: {
        heritage: [],
        talent: [],
        perfection: {min: 0, max: 100}
      }
    }
  },
  computed: {
    load_ready () {
      return this.pagination_stats.has_next
    },
    chicken_derbies() {
      return this.$store.getters['chickenderby/chicken_derbies']
    },
    loading_data() {
      return this.$store.getters['chickenderby/loading_chicken_derbies']
    },
    heritage_options() {
      return [{label: 'Dorking', value: 'Dorking'},
        {label: 'Lakenvelder', value: 'Lakenvelder'},
        {label: 'Sultan', value: 'Sultan'}, {label: 'Serama', value: 'Serama'}]
    },
    talent_options() {
      return [
        {label: 'Rollerblades', value: 'Rollerblades'},
        {label: 'CK-47', value: 'CK-47'},
        {label: 'Chickenapult', value: 'Chickenapult'},
        {label: 'Anvil', value: 'Anvil'},
        {label: 'Coober', value: 'Coober'},
        {label: 'Machete', value: 'Machete'},
        {label: 'Blue Rooster', value: 'Blue Rooster'},
        {label: 'Blue Egg', value: 'Blue Egg'},
        {label: 'Black Hole', value: 'Black Hole'},
        {label: 'Helicopter', value: 'Helicopter'},
        {label: 'Dig', value: 'Dig'},
        {label: 'Devolution', value: 'Devolution'},
        {label: 'Cold Snap', value: 'Cold Snap'}
      ]
    }
  },
  watch: {
    filters: {
      deep: true,
     handler(value){
       this.pagination_stats =   {
         count: 0,
         first: 0,
         has_next: false,
         has_prev: false,
         last: 0,
         next_page: 1,
         page: 0,
         prev_page: 0,
         limit: 10
       }
       this.fetch_chicken_derbies_reset()
     }
    }
  },
  mounted() {
    const socket = new Socket("ws://api.chickenstats.com/socket")
    socket.connect()
    const channel =
      socket.channel(`chicken_derby`)
    channel.join()
      .receive("ok", resp => {
        console.log("success")
      })
      .receive("error", resp => {
        console.log(resp)
      })
    channel.on("derbies", payload => {
      this.$store.dispatch('chickenderby/append_item', [payload])
    })
  },
  created() {
    this.fetch_chicken_derbies()
  },
  methods: {
    async fetch_chicken_derbies() {
      let params = this.pagination_stats.has_prev && this.pagination_stats.has_next
        ? {page: this.pagination_stats.next_page, limit: this.pagination_stats.limit, filters: this.filters}
        : {page: this.pagination_stats.next_page, limit: this.pagination_stats.limit, filters: this.filters}
      await this.$store.dispatch('chickenderby/fetch_chicken_derbies', params).then((r) => {
        this.pagination_stats = r.data.stats
      })
    },
    async fetch_chicken_derbies_reset() {
      let params = this.pagination_stats.has_prev && this.pagination_stats.has_next
        ? {page: this.pagination_stats.next_page, limit: this.pagination_stats.limit, filters: this.filters}
        : {page: this.pagination_stats.next_page, limit: this.pagination_stats.limit, filters: this.filters}
      await this.$store.dispatch('chickenderby/fetch_chicken_derbies_reset', params).then((r) => {
        this.pagination_stats = r.data.stats
      })
    }
}
})
</script>
