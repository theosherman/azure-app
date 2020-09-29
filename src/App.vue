<template lang="pug">
div
  h1 Azure Static Web App
  hr
  button(@click='callApi()') Call API
</template>

<script>
import axios from 'axios'

export default {
  name: 'App',
  setup() {
    async function callApi() {
      const { data } = await axios.post('/api/login', { name: 'Theo' })
      console.log(data)
    }

    return {
      callApi
    }
  }
}
</script>