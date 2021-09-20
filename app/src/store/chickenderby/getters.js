export function chicken_derbies(state) {
  return state.chicken_derbies.sort(function (a, b) {
    return a.created_at - b.created_at;
  });
}

export function loading_chicken_derbies(state) {
  return state.loading
}
