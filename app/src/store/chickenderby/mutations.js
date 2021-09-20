export function store_chicken_derbies (state, data) {
  state.chicken_derbies = [...state.chicken_derbies, ...data];
}

export function store_chicken_derbies_reset(state, data){
  state.chicken_derbies = data
}

export function store_loading_chicken_derbies (state, status) {
  state.loading = status;
}

export function socket_data (state, data) {
  state.chicken_derbies =  [...data, ...state.chicken_derbies]
}

