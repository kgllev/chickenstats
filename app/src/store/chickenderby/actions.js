export function fetch_chicken_derbies({commit, dispatch}, params) {
  return new Promise((resolve, reject) => {
    commit('store_chicken_derbies', []);
    commit('store_loading_chicken_derbies', true)
    this.$axios.get('chicken-derby',  {
      params: params
    })
      .then((r => {
        commit('store_chicken_derbies', r.data.data);
        commit('store_loading_chicken_derbies', false)
        return resolve(r);
      }))
      .catch((e => {
        commit('store_loading_chicken_derbies', false)
      }))
  })
}

export function fetch_chicken_derbies_reset({commit, dispatch}, params) {
  return new Promise((resolve, reject) => {
    commit('store_chicken_derbies_reset', []);
    commit('store_loading_chicken_derbies', true)
    this.$axios.get('chicken-derby',  {
      params: params
    })
      .then((r => {
        commit('store_chicken_derbies', r.data.data);
        commit('store_loading_chicken_derbies', false)
        return resolve(r);
      }))
      .catch((e => {
        commit('store_loading_chicken_derbies', false)
      }))
  })
}

export function append_item({commit}, data) {
  commit('socket_data', data);
}
