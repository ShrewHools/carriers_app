$(document).on('turbolinks:load', function() {
  function fetchLowestBid() {
    const route = $('#bid_shipping_route_id').val();
    const loadType = $('#bid_load_type_id').val();

    $.ajax({
      url: '/bids/fetch_lowest_bid',
      method: 'GET',
      data: { route: route, load_type: loadType },
      success: function(response) {
        $('#minBidValue').text(response.lowestBid);
        $('#minBidInfo').fadeIn();
      },
      error: function() {
        $('#minBidInfo').fadeOut();
      }
    });
  }

  if ($('.bid_form').length) {
    fetchLowestBid();
  }
  $('#bid_shipping_route_id, #bid_load_type_id').on('change', fetchLowestBid);
});
