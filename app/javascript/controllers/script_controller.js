import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="script"
export default class extends Controller {
  connect() {
    console.log('connected')
  }

  toggleTab(event) {
    const platformName = event.target.dataset.value;
    const activeTab = document.querySelector('.nav-link.active');
    const activeTabContent = document.querySelector('.tab.d-block');
    const tabToToggle = event.target;
    const tabContentToToggle = document.getElementById(`${platformName}-script`);

    activeTab.classList.remove('active');
    tabToToggle.classList.add('active');
    activeTabContent.classList.replace('d-block', 'd-none');
    tabContentToToggle.classList.replace('d-none', 'd-block');
  }
}
