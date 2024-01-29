import Story from "./Story";
class TopStories {
    stories: Array<Story>;

    constructor() {
        this.stories = [];
    }

    addStory(story: Story) {
        this.stories.push(story);
    }

    getTopStories() {
        
    }
}

export default TopStories;